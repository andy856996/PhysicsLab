clear all; clc;
grid_size = 0.1;
mask = cif2mask_fixbox_v4('./test.cif',grid_size);
figure;contour(mask);axis equal;