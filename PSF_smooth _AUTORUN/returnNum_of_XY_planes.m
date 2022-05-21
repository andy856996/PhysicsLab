%% function
function Num_of_XY_planes = returnNum_of_XY_planes(data_path,depthOfPMMA)
    fid=fopen(data_path);
    for i=1:1:7
        tline=fgetl(fid);
    end
    Num_of_XY_planes = round(depthOfPMMA/str2num(tline(find(tline ==':')+1:find(tline =='n')-2)))-1;%% Stopping calculation of "XY plane" layer
    fclose(fid);
end