Z = 10 + peaks;
Z = Z / max(max(Z));
[row,col] = size(Z);
[xx,yy] = meshgrid(1:1:row,1:1:col);
[xx_small,yy_small] = meshgrid(1:0.01:row,1:0.01:col);
Z_big = interp2(xx,yy,Z,xx_small,yy_small);
imagesc(xx_small(1,:),yy_small(:,1),Z_big)
colormap jet;
colorbar;