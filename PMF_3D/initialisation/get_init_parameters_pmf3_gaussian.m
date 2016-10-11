function [ pmf ] = get_init_parameters_pmf3_gaussian( )
%GET_INIT_PARAMETERS_PMF3_GAUSSIAN Summary of this function goes here
%   Detailed explanation goes here


length.m = 1; % meters
length.n = 1; % meters
length.k = 1; % meters

delta_m = 0.05;
delta_n = 0.05;
delta_k = 0.05;

m = floor(length.m/delta_m);
n = floor(length.n/delta_n);
k = floor(length.k/delta_k);

No          =   300;
N1          =   4000;
eps         =   0.001;
delta.m     = delta_m;
delta.n     = delta_n;
delta.k     = delta_k;
min_delta_n = delta_n/2/2/2/2;


pmf      = pmf3_create([0 0 0]',delta,min_delta_n,length,m,n,k,No,N1,eps);
pmf      = initialise_pmf_3D_gaussian(pmf,0.01);


end

