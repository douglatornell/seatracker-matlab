function rhs=derivatives(t, poss, deltat, t_mask, e3w, e2v, e1u, w_coords, v_coords, ...
    u_coords, w, v, u)
    rhs = zeros(size(poss));
    step = size(poss, 1)/3;
    for ip=1:step
        point = [t poss(ip) poss(ip+step) poss(ip+2*step)];
        [A, B, C] = interpolator(deltat, t_mask, ...
                                          e3w, e2v, e1u, w_coords, v_coords, u_coords, w, v, u, point);
        rhs(ip) = A;
        rhs(ip+step) = B;
        rhs(ip+step*2) = C;
    end
    