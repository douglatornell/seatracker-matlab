function rhs_vel=interpolate_vel(dims, deltat, vel, scale, coords, data, point)
    good = true(1);
    for j = 1:dims
        idx = discretize((point(j)), coords(j, :)); % finds the index of region
        if (idx == length(coords(j, :)))
             print (j, 'out of bounds', point(j), vel, coords(j, :))
             good = False;
        elseif (idx == 0)
             print (j, 'hit surface', point(j), vel, coords(j, :))
             good = False;
        elseif idx ~= idx
            'Ran beyond time'
        else
             index(j, 1) = idx;
             index(j, 2) = idx+1;
             if j==1
                 pos(j) = (point(j) - coords(j, idx))/deltat;
             else
                 pos(j) = point(j) - coords(j, idx);
             end
        end
    end
    if good
       for m=1:2
       for k=1:2
           for j=1:2
               for i=1:2
                   sub_data(i, j, k, m) = data(index(4, m), index(3, k), ...
                       index(2, j), index(1, i));
               end
            end
       end
       end
        li = interpn(sub_data, pos(1)+1, pos(2)+1, pos(3)+1, pos(4)+1);
        if vel == 1
                rhs_vel = li/scale(index(4, 1), index(3, 1), index(2, 1), index(1, 1));
        else
                rhs_vel = li/scale(index(4, 1), index(3, 1));
        end
     else
        rhs_vel = 0.;
    end