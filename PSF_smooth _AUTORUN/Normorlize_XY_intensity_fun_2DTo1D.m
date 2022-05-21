function [energy num_line] = Normorlize_XY_intensity_fun_2DTo1D(y_test,Normorlize_xy_plane_intensity)
for i=1:1:length(y_test)
    [row,~] = find(Normorlize_xy_plane_intensity == y_test(i));
    if ~isempty(row)
        energy(i) = y_test(i);
        num_line(i) = length(row);
    else
        energy = 0;
        break;
    end

end
end
