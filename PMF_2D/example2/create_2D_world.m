function [ world ] = create_2D_world(options)
%CREATE_2D_WORLD Creates a simple 2D world which consits of an outer square
% delimiting the edge of the world, and an in square which represents the 
% goal region 
%
%   input ----------------------------------------------------------
%
%       o options.outer_dx : (1 x 1), size of the outer wall
%
%       o options.inner_dx : (1 x 1), size of the inner box
%
%
%
%

if ~isfield('options','outer_dx'),options.outer_dx = 10;end
if ~isfield('options','inner_dx'),options.inner_dx = 1;end



dx               = options.outer_dx;     
world.outer_dx   = dx;
world.outer_walls      = [[-dx,-dx,-dx, dx];
                    [-dx, dx, dx, dx];
                    [ dx, dx, dx,-dx];
                    [ dx,-dx,-dx,-dx]];       

world.corners    = [ dx , dx;                
                    -dx , dx;
                     dx ,-dx;
                    -dx ,-dx];
                
world.closest_points = [ dx,  0;
                        -dx,  0;
                          0, dx;
                          0,-dx];
                
                
dx               = options.inner_dx;     
world.inner_dx   = dx;
world.inner_walls      = [[-dx,-dx,-dx, dx];
                    [-dx, dx, dx, dx];
                    [ dx, dx, dx,-dx];
                    [ dx,-dx,-dx,-dx]];    
                
                
                

end

