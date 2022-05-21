function [matrix num_line]= Normorlize_XY_intensity_fun_1DTo2D(x,y,sqrt_of_radius_matrix)
[row_radius,col_radius] = size(sqrt_of_radius_matrix);
matrix = zeros(row_radius,col_radius);
for i=1:1:length(y)
    [row,col] = find(sqrt_of_radius_matrix == x(i));
    for j=1:1:length(row)
        matrix(row(j),col(j)) = y(i);
        num_line(i) = length(row);
    end
end
end
