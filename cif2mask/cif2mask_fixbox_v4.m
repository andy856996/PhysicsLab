function y=cif2mask_fixbox_v4(filename,grid_size)
sampling_period_x_mask=grid_size;
sampling_period_y_mask=grid_size;
%% Open CIF file
fid=fopen(filename,'r');
N=0;
while feof(fid)==0
    N=N+1;
    %celReturn saves the infomation of input file
    CelReturn(N).info=fgetl(fid);
    
end
fclose(fid);
%% get Nx Ny
arr_ = '';
for i=1:length(CelReturn)
    arr_ = [arr_ CelReturn(i).info];
end
arrr = find(arr_==',');
X_num = [];Y_num = [];
for i =1:length(arrr)
    index = arrr(i);
    while true
        index = index -1;
        if (arr_(index) == '-' ) || (arr_(index) == ' ')
            X_num(i) = str2double(arr_(index : arrr(i)-1));
            break;
        end
    end
end
for i =1:length(arrr)
    index = arrr(i);
    while true
        index = index + 1;
        if (arr_(index) == ' ' ) || (arr_(index) == ';')
            Y_num(i) = str2double(arr_(arrr(i)+1:index-1));
            break;
        end
    end
end
%======================================
% Read polygon cell position
scale_index=0;
poly_num=0;
box_num=0;
line_num=1;
char_num=1;
box_index='';
poly_index='';

while(line_num<length(CelReturn))
    if (length(CelReturn(line_num).info)==0)
        line_num=line_num+1;    
    else
        if (CelReturn(line_num).info(1)=='D')&&(CelReturn(line_num).info(2)=='S')%first two char = 'DS'
    	scale_index=line_num;
    	line_num=line_num+1;
        end
    
        if (CelReturn(line_num).info(char_num)=='P')%get 'P 'for polygon
            char_num=char_num+1;
            if (CelReturn(line_num).info(char_num)==' ')
                poly_char=1;%poly_char count set to 1
                break_flag=1;
                poly_num=poly_num+1;
                while(break_flag)
                    char_num=char_num+1;
                    if (char_num>length(CelReturn(line_num).info))
                        line_num=line_num+1;
                        char_num=1;
                    end
                    if (CelReturn(line_num).info(char_num)==';')
                        break_flag=0;
                    elseif (CelReturn(line_num).info(char_num)==',')
                        poly_index(poly_num,poly_char)=' ';
                        poly_char=poly_char+1;
                    else
                        poly_index(poly_num,poly_char)=CelReturn(line_num).info(char_num);%put char in line into index
                        poly_char=poly_char+1;
                    end
                end
            end

        elseif(CelReturn(line_num).info(char_num)=='B')%get 'B 'for box
            char_num=char_num+1;
            if (CelReturn(line_num).info(char_num)==' ')
                box_char=1;%box_char count set to 1
                break_flag=1;
                box_num=box_num+1;
                while(break_flag)
                    char_num=char_num+1;
                    if (char_num>length(CelReturn(line_num).info))
                        line_num=line_num+1;
                        char_num=1;
                    end
                    if (CelReturn(line_num).info(char_num)==';')
                        %char_num=char_num+1;
                        break_flag=0;
                    elseif (CelReturn(line_num).info(char_num)==',')
                        box_index(box_num,box_char)=' ';
                        box_char=box_char+1;
                    else
                        box_index(box_num,box_char)=CelReturn(line_num).info(char_num);%put char in line into index
                        box_char=box_char+1;
                    end               
                end
            end
        else
            char_num=char_num+1;
            if (char_num>length(CelReturn(line_num).info))
                line_num=line_num+1;
                char_num=1;
            end
        end
    end
end
%==========================================================================
if (length(box_index(:))~=0)
    box_count=0;
    while(box_count<length(box_index(:,1)))%change coordinates on all boxes
        box_count=box_count+1;
        box_coordinate=str2num(box_index(box_count,:));
        %convert box coordinate into poly coordinate
        %put poly coordinate into poly_index in char mode using num2str
        if(length(poly_index)==0)%avoide error when no poly in cif file
            %following code can be simplified if matrix dimension problem
            %can be solved
            poly_coordinate_x(box_count).data(1)=box_coordinate(3)-box_coordinate(1)/2;
            poly_coordinate_y(box_count).data(1)=box_coordinate(4)-box_coordinate(2)/2;
            poly_coordinate_x(box_count).data(2)=box_coordinate(3)+box_coordinate(1)/2;
            poly_coordinate_y(box_count).data(2)=box_coordinate(4)-box_coordinate(2)/2;
            poly_coordinate_x(box_count).data(3)=box_coordinate(3)+box_coordinate(1)/2;
            poly_coordinate_y(box_count).data(3)=box_coordinate(4)+box_coordinate(2)/2;
            poly_coordinate_x(box_count).data(4)=box_coordinate(3)-box_coordinate(1)/2;
            poly_coordinate_y(box_count).data(4)=box_coordinate(4)+box_coordinate(2)/2;
        else
            poly_coordinate_x(length(poly_index(:,1))+box_count).data(1)=box_coordinate(3)-box_coordinate(1)/2;
            poly_coordinate_y(length(poly_index(:,1))+box_count).data(1)=box_coordinate(4)-box_coordinate(2)/2;
            poly_coordinate_x(length(poly_index(:,1))+box_count).data(2)=box_coordinate(3)+box_coordinate(1)/2;
            poly_coordinate_y(length(poly_index(:,1))+box_count).data(2)=box_coordinate(4)-box_coordinate(2)/2;
            poly_coordinate_x(length(poly_index(:,1))+box_count).data(3)=box_coordinate(3)+box_coordinate(1)/2;
            poly_coordinate_y(length(poly_index(:,1))+box_count).data(3)=box_coordinate(4)+box_coordinate(2)/2;
            poly_coordinate_x(length(poly_index(:,1))+box_count).data(4)=box_coordinate(3)-box_coordinate(1)/2;
            poly_coordinate_y(length(poly_index(:,1))+box_count).data(4)=box_coordinate(4)+box_coordinate(2)/2;
        end
    end  
end
%==========================================================================
poly_count=0;
if(length(poly_index)~=0)%skip following processes when no poly in file
    while(poly_count<length(poly_index(:,1)))
        poly_count=poly_count+1;
        x_count=1;
        y_count=1;
        xy_count=1;
        poly_coordinate=str2num(poly_index(poly_count,:));
        while (xy_count<=length(poly_coordinate))
            %to avoide problem caused by (0,0), a preset 2d array will fill
            %blank with 0. so each line is processed separately
            if(rem(xy_count,2))%x coordinates
                poly_coordinate_x(poly_count).data(x_count)=poly_coordinate(xy_count);
                x_count=x_count+1;
            else%y coordinates
                poly_coordinate_y(poly_count).data(y_count)=poly_coordinate(xy_count);
                y_count=y_count+1;
            end
            xy_count=xy_count+1;
        end
    end
end
%==========================================================================
% Find scale factor
%find the "DS 1 1 N" of the original input file
%the thrid number, N, is the scale factor
l=length(CelReturn(scale_index).info);
scale_line=str2num(CelReturn(scale_index).info(3:(l-1)));
scale_factor=scale_line(3);
%==========================================================================
%rescale the unit 
%the unit in this format is nm
for i=1:poly_num+box_num
    %poly_coordinate_x(i).data=poly_coordinate_x(i).data.*(0.01/sampling_period_x_mask*scale_factor^-1);
    %poly_coordinate_y(i).data=poly_coordinate_y(i).data.*(0.01/sampling_period_y_mask*scale_factor^-1);
    
    if (min(X_num) < 0) || (min(Y_num) < 0)
        poly_coordinate_x(i).data=(poly_coordinate_x(i).data + abs(min(X_num))) / grid_size * scale_factor^-1;
        poly_coordinate_y(i).data=(poly_coordinate_y(i).data + abs(min(Y_num))) / grid_size * scale_factor^-1;
    else
        poly_coordinate_x(i).data=(poly_coordinate_x(i).data) / grid_size * scale_factor^-1;
        poly_coordinate_y(i).data=(poly_coordinate_y(i).data) / grid_size * scale_factor^-1;
    end
end
%==========================================================================
%==========================================================================
% Elineate pattern with given points
if (min(X_num) < 0) || (min(Y_num) < 0)
    Nx = (max(X_num)+abs(min((X_num))))* scale_factor^-1 /grid_size;
    Ny = (max(Y_num)+abs(min((Y_num))))* scale_factor^-1 /grid_size;
else
    Nx = (max(X_num)+min(X_num)) * scale_factor^-1 /grid_size;
    Ny = (max(Y_num)+min(Y_num)) * scale_factor^-1 /grid_size;
end

y=cast(zeros(fix(Ny),fix(Nx)),'logical');
for i=1:poly_num+box_num
    y=y|poly2mask(poly_coordinate_x(i).data,poly_coordinate_y(i).data,fix(Ny),fix(Nx));
end
[row,col] = size(y);
y = [zeros(row,fix(col/4)) y zeros(row,fix(col/4))];
[row,col] = size(y);
y = [zeros(fix(row/4),col);y;zeros(fix(row/4),col)];
%==========================================================================
%this section fix the poly2mask function, see detail in poly2mask
%algorithem
 y=cast(y,'single');
end