function [A, B, C]=interpolator(deltat, t_mask, e3w, e2v, e1u, w_coords, v_coords, u_coords, ...
    w, v, u, point)
    dims = length(point);
    A=0; B=0; C=0;
    if t_mask(floor(point(4)), floor(point(3)), floor(point(2))) ~= 0
        A = interpolate_vel(dims, deltat, 1, e3w, w_coords, w, point);
        B = interpolate_vel(dims, deltat, 2, e2v, v_coords, v, point);
        C = interpolate_vel(dims, deltat, 3, e1u, u_coords, u, point);   
    end
% original python from Jaime on Stackoverflow https://stackoverflow.com/users/110026/jaime