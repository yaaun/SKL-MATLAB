function reklama
    clear;
    cla;
    xdim = 50;
    ydim = 50;
    zdim = 30;


    [verts, faces] = newBox(0, 0, 0, xdim, ydim, zdim);
    [vertsB, facesB] = newBox(xdim, 0.6 * ydim, 0, xdim, 0.4 * ydim, zdim);
    [vertsC, facesC] = newBox(1.6 * xdim, ydim, 0, 0.35 * xdim, 0.2 * ydim, 0.3 * zdim);
    [vertsD, facesD] = newBox(1.6 * xdim, 1.2 * ydim, 0, 0.4 * xdim, 1.4 * ydim, zdim);
    [vertsR1, facesR1] = newBox(0.1 * xdim, 0.3 * ydim, zdim, 0.7 * xdim, 0.5 * ydim, 0.2 * zdim);

    vertcount = size(verts, 1);
    verts = [verts; vertsB; vertsC; vertsD; vertsR1];
    faces = [faces; facesB + vertcount; facesC + vertcount * 2;
        facesD + vertcount * 3; facesR1 + vertcount * 4];

    % Move all vertices by (-50, -50)
    %verts = verts + zeros(size(verts, 1), 1)
    cdata = hsv(size(verts, 1));
    dcdata = [cdata ; cdata];

    %{
    size(verts, 1)
    size(faces, 1)
    %}

    subplot(2, 2, 2);

    P = patch('Vertices', verts, 'Faces', faces,...
        'EdgeColor', 'b', 'FaceColor', 'interp', 'FaceVertexCData', cdata);

    view(3);
    camzoom(0.9);
    axis equal;
    axis off;
    ttl = title('WFiIS', 'fontsize', 28, 'position', [50, 50, 60]);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');

    %{
    X = -2*pi : 0.1*pi : 2*pi;
    Y = X';
    Z = cos(X.^2 + Y.^2)./(X.^2 + Y.^2 + 0.2);
    %}
    
    [X, Y] = meshgrid(-4*pi : 0.1*pi : 4*pi);

    stablehsv = hsv(300);
    %{
    Xq = linspace(-5, 5, 200);
    Xq1 = Xq(Xq <= 0);
    Xq2 = Xq(and(Xq >= 0, Xq <= 1));
    Xq3 = Xq(Xq >= 1);
    Yheavy = heaviside(Xq) .* 0.5;
    [B, C, D, E, k] = qmbarrier(1, 1, 1 / 1824);
    %}
    xa_min = -5;
    xa_max = 5;
    ya_min = -3;
    ya_max = 3;
    flow_count = 7;
    flow_length = 1.5;
    flow_elem = 30;
    flow_amplitude = 0.3;
    xfs = zeros(flow_count, flow_elem);
    rands = rand(flow_count);
    
    for i = 1 : flow_count
        r = rand() * (xa_max - xa_min);
        xf = linspace(xa_min - flow_length + r, xa_min + r, flow_elem);
        xfs(i, :) = xf;
    end
    
    subplot(2, 2, [3, 4]);
    annota = annotation('textbox',...
        'String', {'WFiIS', 'AGH'},...
        'FontSize', 18,...
        'FontWeight', 'bold',...
        'LineStyle', 'none',...
        'Position', [0, rands(1,2) / (xa_max - xa_min), 0.1, 0.1]...
    );
    %annotb = annotation('textbox', 'String', 'AGH', 'FontSize', 18, 'LineStyle', 'none');
    
    t = 0;
    while true
      subplot(2, 2, 1);
      a = sqrt(X.^2 + Y.^2) + t / 30;
      b = X + Y + t / 30;
      Z = (sin(a) + cos(b)) / 2;
      surfl(X, Y, Z);
      shading interp;
      %axis off;
      axis([-4*pi, 4*pi, -4*pi, 4*pi, -3, 3]);
      
      subplot(2, 2, 2);
      %cdata = get(P, 'FaceVertexCData');
      %cdata = mod(cdata + 1/30, 1);
      
      cstart = mod(t, size(cdata, 1)) + 1;
      cend = cstart + size(cdata, 1) - 1;
      
      if isvalid(P)
          set(P, 'FaceVertexCData', dcdata(cstart:cend,:));
          set(ttl, 'Color', stablehsv(mod(t, size(stablehsv, 1) - 1) + 1,:));
        %set(P(i), 'cameraviewangle', offs);
          view(mod(t * 4, 360), 35);
      else
          break;
      end
      
      subplot(2, 2, [3, 4]);
      %{
      Yl1 = real(exp(1i * (Xq1 - t / 30)));
      Yr1 = real(B .* exp(-1i * (Xq1 - t / 30)));
      Yl2 = real(C .* exp(1i * (Xq2 - t / 30)));
      Yr2 = real(D .* exp(-1i * (Xq2 - t / 30)));
      Yl3 = real(E .* exp(1i * (Xq3 - t / 30)));
      
      plot(Xq1, Yl1, 'k', Xq1, Yr1, 'm', Xq2, Yl2, 'r', Xq2, Yr2, 'y', Xq3, Yl3, 'b');
      axis([Xq(1), X(end), -1.5 , 1.5]);
      %}
      

      cla;
      hold on;
      axis([xa_min, xa_max, ya_min, ya_max]);
      
      for n = 1 : size(xfs,1)
          if min(xfs(n, :)) > xa_max
              xfs(n, :) = linspace(xa_min - flow_length, xa_min, flow_elem);
              rands(n) = rand();
          else
              xfs(n, :) = xfs(n, :) + 1 / 30;
          end
          
          yf = flow_amplitude * sin(xfs(n, :) * 10) + (2 * rands(n) - 1) * (ya_max - flow_amplitude);
          plot(xfs(n, :), yf);
          
      end
      
      if mod(t, 180) == 0
          randannot = rand() * 0.5;
      end
      
      set(annota, 'Color', stablehsv(size(stablehsv, 1) - mod(t, size(stablehsv, 1) - 1),:));
      set(annota, 'Position', [mod(t / 180, 1) * 1.1 - 0.1, randannot + 0.05 * sin(t / 18 * 2*pi), 0.1, 0.2]);
      
      %plot(xfs(1,:), sin(xfs(1,:)));
      
      t = t + 1;
      pause(1/30);
    end
end

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
    5 6 7 8
  ];
end
