classdef PMF3 < handle
    %PMF3 Point Mass Filter (3D)
    
    properties
        
        pmf
        pmf_options
        
        
        % motion update parameters
        
        motion_noise
        dist_traveled
        dist_travel_theta
        bStartConv
        b_interpolate
        bFirst
        %   Motion function
        
        motion_f
        kernel_n
        kernel_m
        kernel_k
        k
        sum_vel
        
        %   Measurement functions
        d_edge_f
        d_edge_f2
        hY_contact
        hY_edge
        hY_inserted
        hY_isinside
        
        likelihood_f
        adapt_nmk_f
        
        measurement_noise
        edge_Y_type
        get_tip
        socket_wall
        
    end
    
    methods
        
        function obj = PMF3(pmf_options)
            
            obj.pmf_options   = pmf_options;
            
        end
        
        function obj = initialise(obj,x_peg,q_peg,socket_wall)
            
            obj.motion_noise                = obj.pmf_options.motion_noise;
            obj.measurement_noise           = obj.pmf_options.measurement_noise;
            obj.dist_travel_theta           = obj.pmf_options.dist_travel_theta;  % 0.02
            obj.edge_Y_type                 = obj.pmf_options.edge_Y_type;
            obj.socket_wall                 = socket_wall;
            
            % Initialise belief
            obj.pmf                        = get_init_parametrs_pmf3(x_peg);
            %obj.pmf                        = get_init_parameters_pmf3_gaussian();
            edges                          = get_edges_socket_wall(socket_wall);
            
            obj.bStartConv                 = false;
            obj.b_interpolate              = false;
            obj.dist_traveled              = 0;
            
            %   Motion
            obj.motion_f                   = @(pmf,u,dist_trav,bConvolve)pmf3_motion(pmf,u',obj.motion_noise,dist_trav,obj.dist_travel_theta,bConvolve);
            
            %   Measurement functions
            obj.hY_inserted                = @(tips)peg_inserted2(tips,socket_wall);
            obj.hY_contact                 = @(middle_tip_position)sw_is_in_contact(middle_tip_position,socket_wall,0.02);
            obj.hY_isinside                = @(r)is_inside_sw(r,socket_wall);
            
            
            obj.d_edge_f                   = @(tip_position)sw_min_dist_edge(tip_position,edges);
            obj.d_edge_f2                  = @(tip_position)sw_dist_edge(tip_position,edges);
            
            
            obj.get_tip                    = @(r)get_peg_tip_positions(r,q2r(q_peg));
            obj.hY_edge                    = @(tip_position)sw_edge(tip_position,q2r(q_peg),obj.edge_Y_type,obj.d_edge_f,obj.d_edge_f2);
            hY_f                           = @(tip_positions)measurement_function(tip_positions,obj.hY_contact,obj.hY_edge,obj.hY_inserted);
            obj.adapt_nmk_f                = @(pmf,r)pmf3_adapt_nmk(pmf,r,0.5,8);
            
            tip_positions                  = obj.get_tip(x_peg);
            Y                              = hY_f(tip_positions);
            %
            Sigma                         = diag(ones(1,size(Y,2)).* obj.measurement_noise);
            obj.likelihood_f              = @(Y,hY,b_inside)likelihood_contact(Y,hY,Sigma,b_inside);
            
            
            % Initialise convolution Kernels
            l                = 6;
            obj.kernel_n     = (-l:1:l) * obj.pmf.delta.n;
            obj.kernel_m     = (-l:1:l) * obj.pmf.delta.m;
            obj.kernel_k     = (-l:1:l) * obj.pmf.delta.k;
            obj.k            = 1;
            obj.sum_vel      = zeros(1,3);
            
            obj.bFirst       = true;
            
            
        end
        
        function obj = motion_update(obj,u)
            u = u(:);
            
                       
            [obj.pmf,obj.dist_traveled] = obj.motion_f(obj.pmf,u,obj.dist_traveled,obj.bStartConv);
        end
        
        function [Y,obj]        = sense(obj,x_peg,q_peg)
            obj.get_tip         = @(r)get_peg_tip_positions(r,q2r(q_peg));
            hY_f                = @(tip_positions)measurement_function(tip_positions,obj.hY_contact,obj.hY_edge,obj.hY_inserted);
            tip_positions       = obj.get_tip(x_peg);
            Y                   = hY_f(tip_positions);
        end
        
        function [Y,obj] = measurement_update(obj,Y)
            
     
            hY_f                         = @(tip_positions)measurement_function(tip_positions,obj.hY_contact,obj.hY_edge,obj.hY_inserted);
            obj.pmf                      = pmf3_measurement_update(obj.pmf,Y,hY_f,obj.likelihood_f,obj.hY_isinside,obj.get_tip,obj.socket_wall);
            [obj.pmf,obj.b_interpolate]  = pmf3_adapte(obj.pmf);
            obj.pmf                      = pmf3_truncation( obj.pmf );
            
            
            
            if obj.b_interpolate
                obj.bStartConv  = true;
            end
            
            if Y(2) ~= 0
                obj.bStartConv = false;
            end
            
            
            
        end
        
        function obj = adapt_mnk(obj,x)
            if obj.b_interpolate
                obj.pmf  = obj.adapt_nmk_f(obj.pmf,x);
            end
        end
        
        
        function obj = correct_x_ref(obj,x_peg)
            
            XYZW           = get_pdf_pmf3(obj.pmf);
            [~,I]          = min(sqrt(sum((XYZW(:,1:3) - repmat(x_peg,size(XYZW,1),1)).^2,2)));
            hpos_min       = XYZW(I,1:3);
            
            if size(x_peg,2) ~= size(hpos_min,2)
                disp('PMF3 error');
            end
            
            % hpos_min -> empty
            if isempty(hpos_min)
                obj.pmf.x_ref = x_peg(:);
                idx = cartesian2indices(x_peg(1),x_peg(2),x_peg(3),x_peg,[ obj.pmf.m,obj.pmf.n,obj.pmf.k] ,obj.pmf.delta);
                obj.pmf.P(idx) = 1/length(idx);
                XYZW           = get_pdf_pmf3(obj.pmf);
                [~,I]          = min(sqrt(sum((XYZW(:,1:3) - repmat(x_peg,size(XYZW,1),1)).^2,2)));
                hpos_min       = XYZW(I,1:3);
            end
            
            obj.pmf.x_ref  = obj.pmf.x_ref + (x_peg - hpos_min)';
            
            
        end
        
        function [u,x_peg,x_peg_tmp] = update_peg_position(obj,x_peg,x_peg_tmp,q_peg,u,socket_wall)
            u                       = u(:)';
            x_peg                   = x_peg + u;
            x_peg                   = correct_peg_position(x_peg,q2r(q_peg),socket_wall);
            
            u                       = x_peg - x_peg_tmp;
            x_peg_tmp               = x_peg;
        end
        
    end
    
end

