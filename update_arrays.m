function [tcorrs, u_coords, v_coords, w_coords, u, v, w, nextindex, e3w] = ...
    update_arrays(totaldepth, e3w0, e3w, tcorrs, u_coords, v_coords, w_coords, u, v, w, deltat, nextindex)
    tcorrs = tcorrs + deltat;
    nextindex = nextindex + 1;
    [udataset, vdataset, wdataset, tdataset, useindex] = find_dataset(nextindex);
    u_coords(1, 1:length(tcorrs)) = tcorrs;
    u_coords(1, length(tcorrs)+1:end) = max(tcorrs);
    v_coords(1, :) = u_coords(1, :);
    w_coords(1, :) = u_coords(1, :);
    u(:, :, :, 1:2) = u(:, :, :, 2:3);
    temp = ncread(udataset, 'uVelocity', [1, 1, 1, useindex], [Inf, Inf, Inf, 1]);
    u(:, :, 2:end, 3) = temp;
    u(:, :, 1, 3) = 2 * u(:, :, 2, 3) - u(:, :, 3, 3);
    
    v(:, :, :, 1:2)= v(:, :, :, 2:3);
    temp = ncread(vdataset, 'vVelocity', [1, 1, 1, useindex], [Inf, Inf, Inf, 1]);
    v(:, :, 2:end, 3) = temp;
    v(:, :, 1, 3) = 2 * v(:, :, 2, 3) - v(:, :, 3, 3);
    
    w(:, :, :, 1:2) = w(:, :, :, 2:3);
    temp = ncread(wdataset, 'wVelocity', [1, 1, 1, useindex], [Inf, Inf, Inf, 1]);
    w(:, :, 1:end-1, 3) = -temp;
    w(:, :, end, 3) = 0.;

    e3w(:, :, 1:2) = e3w(:, :, 2:3);
    temp = ncread(tdataset, 'ssh', [1, 1, useindex], [Inf, Inf, 1]);
    [maxj, maxi, maxt] = size(temp);
    for k = 1:size(e3w0, 3)
        e3w(:, :, k, 3) = e3w0(1:maxj, 1:maxi, k) .* (1 + temp(:,:)./totaldepth(1:maxj,1:maxi));
end