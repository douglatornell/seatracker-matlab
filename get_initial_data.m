function [u, v, w, tcorrs, t_coords, u_coords, v_coords, w_coords, deltat, ...
    nextindex, e3w] = get_initial_data(totaldepth, e3w0)
    [udataset, vdataset, wdataset, tdataset, useindex] = find_dataset(1);
    temp = ncread(udataset, 'time');
    tcorrs = temp(1:3);
    deltat = tcorrs(2) - tcorrs(1);
    
  %  u[:, 1:]
    temp = ncread(udataset, 'uVelocity', [1, 1, 1, 1], [Inf, Inf, Inf, 3]);
    u = zeros(size(temp, 1), size(temp, 2), size(temp, 3)+1, 3);
    u(:, :, 2:end, :) = temp(:, :, :, 1:3);
    u(:, :, 1, :) = 2 * u(:, :, 3, :) - u(:, :, 2 ,:);
    
    xcorrs = linspace(1, size(u, 1), size(u, 1));
    ycorrs = linspace(1, size(u, 2), size(u, 2));
    depthsize = size(u, 3);
    zcorrs = linspace(-0.5, depthsize-0.5, depthsize+1);  % this makes it T grid points relative to surface at 0 

    longaxis = max([length(xcorrs) length(ycorrs) length(zcorrs) length(tcorrs)]);
    t_coords = zeros(4, longaxis);
    t_coords(1, 1:length(tcorrs)) = tcorrs;
    t_coords(1, length(tcorrs)+1:end) = max(tcorrs);
    t_coords(2, 1:length(zcorrs)) = zcorrs;
    t_coords(2, length(zcorrs)+1:end) = max(zcorrs);
    t_coords(3, 1:length(ycorrs)) = ycorrs;
    t_coords(3, length(ycorrs)+1:end) = max(ycorrs);
    t_coords(4, 1:length(xcorrs)) = xcorrs;
    t_coords(4, length(xcorrs)+1:end) = max(xcorrs);
    % other grids
    u_coords = t_coords;
    u_coords(4, :) = t_coords(4, :) + 0.5;
    v_coords = t_coords;
    v_coords(3, :) = t_coords(3, :) + 0.5;
    w_coords = t_coords;
    w_coords(2, :) = t_coords(2, :) + 0.5;

    v = zeros(size(u));
    temp = ncread(vdataset, 'vVelocity', [1, 1, 1, 1], [Inf, Inf, Inf, 3]);
    v(:, :, 2:end, :) = temp(:, :, :, 1:3);
    v(:, :, 1, :) = 2 * v(:, :, 3, :) - v(:, :, 2 ,:);

    w = zeros(size(u));
    temp = ncread(wdataset, 'wVelocity', [1, 1, 1, 1], [Inf, Inf, Inf, 3]);
    w(:, :, 1:end-1, :) = - temp(:, :, :, 1:3); % change to velocity down (increasing depth)

    temp = ncread(tdataset, 'ssh', [1, 1, 1], [Inf, Inf, 3]);
    ssh = temp(:, :, 1:3);
    e3w = zeros(size(w));
    [maxj, maxi, maxt] = size(temp);
    for i = 1:3
        for k = 1:size(e3w0, 3)
            e3w(:, :, k, i) = e3w0(1:maxj, 1:maxi, k) .* (1 + ssh(:, :, i)./totaldepth(1:maxj,  1:maxi));
        end
    end
    
    nextindex = 3;