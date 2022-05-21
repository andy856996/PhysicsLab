function [x_new y_new]=take_zero_out(x,y)

mean_of_intensity_times_Avg = y;% y_test_2um_cut ; y_test_smooth  ; y_test_smooth_0nm_BL
sqrt_of_radius = x; % x_2um_cut ; x_0nm_BL

[m,n]=size(mean_of_intensity_times_Avg);
r_need=sqrt_of_radius(:,:,1);
j=1;
for iii=1:m
    if mean_of_intensity_times_Avg(iii,1)>0
        nonzero_index(j)=iii;
        j=j+1;
    end
end
k=1;
for iii=1:j-1
    r_out(k)=r_need(nonzero_index(iii),1);
    I_out(k)=mean_of_intensity_times_Avg(nonzero_index(iii),1);
    k=k+1;
end
x_new=r_out';
y_new=I_out';

