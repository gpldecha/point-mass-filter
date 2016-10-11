function [pmf] = get_init_parametrs_pmf3(r)
%GET_INIT_PARAMETRS_PMF3 Summary of this function goes here
%   Detailed explanation goes here


%%
length.m = 0.5; % meters
length.n = 1.2; % meters
length.k = 0.15; % meters

delta_m = 0.04;
delta_n = 0.04;
delta_k = 0.02;

m = floor(length.m/delta_m);
n = floor(length.n/delta_n);
k = floor(length.k/delta_k);

% length.m = 5; % meters
% length.n = 5; % meters
% length.k = 5; % meters
% 
% delta_m = 0.025;
% delta_n = 0.025;
% delta_k = 0.025;
% 
% m = floor(length.m/delta_m);
% n = floor(length.n/delta_n);
% k = floor(length.k/delta_k);
% 
No          =   300;
N1          =   4000;
eps         =   0.001;
delta.m     = delta_m;
delta.n     = delta_n;
delta.k     = delta_k;
min_delta_n = delta_n/2/2/2/2;

%%

x_ref    = zeros(3,1);
x_ref(1) = 0.4;
x_ref(3) = r(3);
pmf      = pmf3_create(x_ref,delta,min_delta_n,length,m,n,k,No,N1,eps);
pmf      = initialise_pmf_3D_cube(pmf,r);
%pmf      = initialise_pmf_3D_gaussian(pmf,2.*r,0.001);



end

