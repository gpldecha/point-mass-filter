function surfaces = create_surface()
%CREATE_SURFACE Summary of this function goes here
%   Detailed explanation goes here

%surfaces = zeros(4,3);
surf1 = [0,  0.01,0.008;
            0,  -0.01,0.008;
        -0.01,  -0.01,0.008;
         -0.01,  0.01,0.008];
     
surf2 = [-0.01,  0.01,0.008;
            0,   0.01,0.008;
            0,   0.02,-0.002;
         -0.01,  0.02,-0.002];
     
surf3 = [   0,  -0.02,-0.0012;
        -0.01,  -0.02,-0.0012;
        -0.01,  -0.01,-0.01;
            0,  -0.01,-0.01];
     
surf4 = [0, -0.01, -0.01;
         -0.01, -0.01, -0.01;
          -0.01, 0.01, -0.01;
          0, 0.01,-0.01
          ];
        
surf5 = [-0.01, 0.01, -0.01;
          0,    0.01, -0.01;
          0,    0.02, -0.002;
          -0.01, 0.02,-0.002];
      
surf6 = [-0.01, 0.02, -0.002;
          0,    0.02, -0.002;
          0,    0.01, 0.008;
         -0.01, 0.01, 0.008];
      
      
surfaces = [surf1;surf2;surf3;surf4;surf5;surf6];     

end



