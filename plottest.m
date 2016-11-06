X = -2*pi : 0.1 * pi : 2*pi;
Y = sin(X);
offs = 0;


plot(X,Y);
axis manual;
axis([-3 3 -4 4]);

for i=1:100
  offs = offs + 0.1;
  Y = sin(X .+ offs);
  plot(X,Y);
  axis manual;
  axis([-3 3 -4 4]);
  pause(0.01);
end
