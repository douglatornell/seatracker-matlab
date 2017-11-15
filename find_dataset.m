function [udataset, vdataset, wdataset, tdataset, useindex] = find_dataset(nextindex)
    stem1='SS_velocity_';
    stem2='SS_ssh_';
    if nextindex <= 24
        datefield = '09apr16';
        useindex = nextindex
    elseif nextindex <= 48;
        datefield = '10apr16';
        useindex = nextindex-24
    else
        'problem, out of data'
    end
    udataset = strcat(stem1,datefield,'_U.nc');
    vdataset = strcat(stem1,datefield,'_V.nc');
    wdataset = strcat(stem1,datefield,'_W.nc');
    tdataset = strcat(stem2,datefield,'_T.nc');