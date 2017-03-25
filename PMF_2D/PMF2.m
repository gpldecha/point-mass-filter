classdef PMF2 < handle
    % PMF2 2D Point Mass Filter
    %
    %   Implementation of the PMF Bayesian state space filter according to
    %   description given in [1]
    %
    %
    %   [1] Recursive Bayesian Estimation Navigation and Tracking
    %   Applications, Niclas Bergman, Chapter 5.
    %
    %   See Algorithm 5.1 (The Point Mass Filter (PMF)) from [1]. The
    %   implemtation follows the same logic.
    %   
    %
    %   description of important variables --------------------------------
    %
    %    o N0 and N1 be some lower and upper limits on the number of nonzero grid points in the mesh.
    %
    %    If N > N1 decimate the mesh, i.e., remove every second row and
    %    column in P.
    %
    %    If N<N0 interpolate one new point-mass between every neighboring pair 
    %    in the matrix.   
    %
    %    see page 93 of [1]
    %
    %
    
    properties
     
        pmf
        
        % Initialisation function used to initiate the values of the grid
        % cells of the PMF (these are stored in pmf.P)
        initialisation_f
        
        % Convolution kernel (N x 1), used during the motion blur step. 
        kernel              % - (N x 1), values of the Gaussian convolution kernel.
        motion_noise        % - amount of variance for the Gaussian convolution kernel.
        kernel_size         % - size of the Gaussian convolution kernel (isotropic).
        
        dist_travelled      % - Keep track of the amount of displacement.  
        theta_dist_travel   % - Distance travelled before a the Gaussian convolution kernel is applied to pmf.P
        
        % Measurement Likelihood parameters
        likelihood_f        % - Likelihood function   f: \hat{Y}, Y -> R        : retuns likelihood given true measurement Y, and expected measruement \hat{Y}.
        measurement_f       % - Measurement function  f: X          -> \hat{Y}  : returns the expected measurement given the current observed state X.
        
        
    end
    
    methods
        %% Constructor
        
        function obj = PMF2(options)
            obj = obj.reset(options);
        end
        
        
        %% Initialisation of object member variables
        
        function obj = reset(obj,options)
            
            % lower bound on the number of allowed non-zero points in P.
            % If N < No, increase the resolution of the grid
            if ~isfield(options,'No')
                options.No                  = 1200;
            end
            
            % upper bound on the number of allowed points in P.
            % If N > N1, decrease the resolution of the grid
            if ~isfield(options,'N1')
                options.N1                  = 1500;
            end
            
            % threashold value used during truncation step which sets small
            % values of pmf.P to zero.
            if ~isfield(options,'eps')
                options.eps                 = 0.001;
            end
            
            % resolution of the grid: distance between neighbouring points
            if ~isfield(options,'delta')
                options.delta               = 0.5;
            end
            
            % number of grid points on x-axis
            if ~isfield(options,'m')
                options.m                   = 40;
            end
            
            % number of grid points on y-axis
            if ~isfield(options,'n')
                options.n                   = 40;
            end
            
            % frame of refernce of the grid (pmf.P)
            if ~isfield(options,'ref')
                options.ref                 = [0 0]';
            end
            
            if ~isfield(options,'motion_noise')
                warning('option.motion_noise not set! setting to default value.');
                obj.motion_noise            = (0.9).^2;
            else
                obj.motion_noise            = options.motion_noise;
            end
            
            
            if ~isfield(options,'kernel_size')
                warning('option.kernel_size not set! setting to default value.');
                obj.kernel_size             = 5;
            else
                obj.kernel_size             = options.kernel_size;
            end
            
            
            if ~isfield(options,'theta_dist_travel')
                warning('option.theta_dist_travel not set! setting to default value.');
                obj.theta_dist_travel       = 1;
            else
                obj.theta_dist_travel       = options.theta_dist_travel;
            end
            
           
            if ~isfield(options,'likelihood_f')
                warning('options.likelihood_f not set!, you need to provide a handle to a likelihood function');
                obj.likelihood_f            = @(pos,rot) 1;
            else
                obj.likelihood_f            = options.likelihood_f;
            end
            
            if ~isfield(options,'initialisation_f')
                warning('options.initialisation_f not set!, you need to provide a handle to an initialisation function');
                obj.initialisation_f        = @(pmf)initialise_pmf2_gauss(pmf,10);
            else
                obj.initialisation_f        = options.initialisation_f;
            end
            
            if ~isfield(options,'measurement_f')
                warning('options.measurement_f not set!, you need to provide a handle to a measurement function');
                 obj.measurement_f          = @(pos,rot) 1;
            else
                obj.measurement_f           = options.measurement_f;
            end
            
            %% Create PMF
            
            obj.pmf                     = create_pmf(options.ref,options.delta,options.m,options.n,options.No,options.N1,options.eps);
            obj.dist_travelled          = 0;
            
            %% Create convolution kernel for motion blur for the motion update step
                        
            l                           = obj.kernel_size;
            x                           = (-l:1:l) * obj.pmf.delta;
            obj.kernel                  = exp(-0.5*(1/(obj.motion_noise * obj.motion_noise)) .* x.^2);
            obj.kernel                  = obj.kernel  ./sum(obj.kernel(:));
            
            %% initialise the distribution of the PMF
            
            obj.initialise();
            
        end
        
        function print(obj)
            disp(' PMF 2D  ');
            disp(' PMF    parameters');
            disp(' ');
            disp(['   pmf.N:             ' num2str(obj.pmf.N)]);
            disp(' Motion parameters');
            disp(' ');
            disp(['   motion_noise:      ' num2str(obj.motion_noise)]);
            disp(['   kernel_size:       ' num2str(obj.kernel_size)]);
            disp(['   dist_travelled:    ' num2str(obj.dist_travelled)]);
            disp(['   theta_dist_travel: ' num2str(obj.theta_dist_travel)]);
            
            
            
        end
        
        function obj = initialise(obj)
            obj.pmf = obj.initialisation_f(obj.pmf);
        end
        
        %% Motion update (independent motion noise)
        %% Algorithm 5.1 (page 95 of Recursive Bayesian Estimation Navigation and Tracking Applciations)
        
        function obj = motion_update(obj,u)
            
            obj.dist_travelled  = obj.dist_travelled + norm(u);
            % 6. Move the grid \bar{x}_{t+1} = \bar{x}_t + u_t
            obj.pmf.x_ref       = obj.pmf.x_ref + u;
            bConvolve           = false;
            
             %  P_{t+1|t} <- P_{t|t} : convovle the discrete probability
             %  distribution with a gaussian kernel.
             %  the convoultion only happens after a certain distance. This
             %  is for computational reasones.
            if obj.dist_travelled >= obj.theta_dist_travel
                obj.pmf.P       = convn(obj.kernel,obj.kernel,obj.pmf.P,'same');
                bConvolve       = true;
            end 
            
            % make sure the discrete probability distribution is normalised
            obj.pmf.P           = obj.pmf.P ./ sum(obj.pmf.P(:));
            
            % 4. Truncate all weights that are less than epsilon
            obj.pmf             = pmf_truncation(obj.pmf);
            
            if bConvolve
                obj.dist_travelled = 0;
            end
            
        end
        
        
        %% Measurement update
        function obj = measurement_update(obj,Y,rot)
            
            I               = find(obj.pmf.P ~= 0);
            [X_I,Y_I]       = ind2sub(size(obj.pmf.P),I);
            
            pos             = indices2cartesian2D(X_I,Y_I,obj.pmf.x_ref,obj.pmf.m,obj.pmf.n,obj.pmf.delta);
            
            
            if exist('rot','var')
                hY          = obj.measurement_f(pos,rot);
            else
                hY          = obj.measurement_f(pos);
            end
            
            L               = obj.likelihood_f(Y,hY);
            
            obj.pmf.P(I)    = obj.pmf.P(I) .* L;
            obj.pmf.P       = obj.pmf.P / sum(obj.pmf.P(:));
            
        end
        
        
    end
    
end

