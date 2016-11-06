clear;
cla;
xdim = 50;
ydim = 50;
zdim = 30;

function [verts, faces] = newBox(x, y, z, xdim, ydim, zdim)
% newBoxVerts(xdim, ydim, zdim) Create a box in the 1st octant of the coordinate system.
% xdim - x dimension
% ydim - y dimension
% zdim - z dimension

  verts = [
    x, y, z ;
    x + xdim, y, z;
    x + xdim, y + ydim, z;
    x, y + ydim, z;
    x, y, z + zdim;
    x + xdim, y, z + zdim;
    x + xdim, y + ydim, z + zdim;
    x, y + ydim, z + zdim
  ];
  
  faces = [
    1 2 3 4;
    1 2 6 5;
    2 3 7 6;
    3 4 8 7;
    4 1 5 8;
    5 6 7 8;
  ];
end



[vertsA, facesA] = newBox(0, 0, 0, xdim, ydim, zdim);
[vertsB, facesB] = newBox(xdim, 0.6 * ydim, 0, xdim, 0.4 * ydim, zdim);
[vertsC, facesC] = newBox(1.6 * xdim, ydim, 0, 0.35 * xdim, 0.2 * ydim, 0.3 * zdim);
[vertsD, facesD] = newBox(1.6 * xdim, 1.2 * ydim, 0, 0.4 * xdim, 1.4 * ydim, zdim);
[vertsR1, facesR1] = newBox(0.1 * xdim, 0.3 * ydim, zdim, 0.7 * xdim, 0.5 * ydim, 0.2 * zdim);


Csa = hsv(length(vertsA));
Csb = hsv(length(vertsB));
Csc = hsv(length(vertsC));
Csd = hsv(length(vertsD));
Csr1 = hsv(length(vertsR1));


subplot(1, 4, [2 3]);

P = [];

P = [P patch('Vertices', vertsA, 'Faces', facesA, 'CData', Csa, 'FaceColor', 'interp', 'EdgeColor', 'b')];
P = [P patch('Vertices', vertsB, 'Faces', facesB, 'CData', Csb, 'FaceColor', 'interp', 'EdgeColor', 'b')];
P = [P patch('Vertices', vertsC, 'Faces', facesC, 'CData', Csc, 'FaceColor', 'interp', 'EdgeColor', 'b')];
P = [P patch('Vertices', vertsD, 'Faces', facesD, 'CData', Csd, 'FaceColor', 'interp', 'EdgeColor', 'b')];
P = [P patch('Vertices', vertsR1, 'Faces', facesR1, 'CData', Csr1, 'FaceColor', 'interp', 'EdgeColor', 'b')];

view(3);
axis equal;
axis off;
%title('WFiIS', 'fontsize', 28);
set(gca, 'XLabel', 'X');
set(gca, 'YLabel', 'Y');
set(gca, 'ZLabel', 'Z');


X = -12*pi : 0.1 * pi : 12 * pi;
offs = 0;

%{
X = -2*pi : 0.1*pi : 2*pi;
Y = X';
Z = cos(X.^2 + Y.^2)./(X.^2 + Y.^2 + 0.2);
%}



while true
  subplot(1, 4, [2 3]);
  for i=1:length(P)
    cdata = get(P(i), 'CData');
    cdata = mod(cdata .+ 1/30, 1);
    set(P(i), 'CData', cdata);
    %set(P(i), 'cameraviewangle', offs);
  end
  
  
  subplot(1, 3, 1);
  offs = offs + 1/30 * pi;
  Y = sin(X .+ offs) ./ (log(abs(X) .+ 0.5) + 1);
  plot(Y,X);
  axis manual;
  axis([-3 3 -12*pi 12*pi]);
  
  pause(1/30);
end