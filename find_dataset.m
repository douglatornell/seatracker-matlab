function [udataset, vdataset, wdataset, tdataset, useindex] = find_dataset(nextindex)
    stem1="SS_velocity_";
    stem2="SS_ssh_";
    if nextindex <= 24
        datefield = "17apr16";
        useindex = nextindex
    elseif nextindex <= 48;
        datefield = "18apr16";
        useindex = nextindex-24;
    else
        'problem, out of data'
    end
    udataset = stem1+datefield+"_U.nc";
    vdataset = stem1+datefield+"_V.nc";
    wdataset = stem1+datefield+"_W.nc";
    tdataset = stem2+datefield+"_T.nc";