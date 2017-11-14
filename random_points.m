function [yi, tc] =random_points (t_coords, deltat, t_mask)
    t0 = t_coords(1, 1);
    nk = 3;
    nj = 3;
    ni = 3;
    npts = nk*nj*ni;
    yi = zeros(npts, 3);

    good = 0;
    while good == 0
        tc = t0 + deltat*rand;
        zc = t_coords(2, end) * rand;
        yc = t_coords(3, 1) + (t_coords(3, end)- t_coords(3, 1)) * rand;
        xc = t_coords(4, 1) + (t_coords(4, end)- t_coords(4, 1)) * rand;

        count = 1;
        for k=1:nk
            for j=1:nj
                for i=1:ni
                    yi(count, 1) = min(zc + k, t_coords(2, end) - 1.5);
                    yi(count, 2) = min(yc + j, t_coords(3, end));
                    yi(count, 3) = min(xc + i, t_coords(4, end));
                    good = good + t_mask(floor(yi(count, 3)), floor(yi(count, 2)), floor(yi(count, 1)));
                    count = count + 1;
                end
            end
        end

        tc
        zc
        yc
        xc
        good
    end