
function [p, q, r, s, Nk] = qmbarrier(na, ne, nm) % Szerokoœæ [Angstrom], energia [eV], masa [u]
    syms a k

    A = [
      -1 1 1 0 ;
      k 1i*k -1i*k k;
      0 exp(-k*a) exp(k*a) -exp(1i*k*a);
      0 1i*k*exp(-k*a) -1i*k*exp(k*a) -k*exp(1i*k*a)
    ];

    % Tutaj za³o¿enie ¿e wspó³czynnik A = 1 (pierwszy w uk³adzie równañ)

    y = [
      1 ;
      k ;
      0 ;
      0
    ];

    d = det(A);

    Ab = A;
    Ab(:,1) = y;
    db = det(Ab);

    Ac = A;
    Ac(:,2) = y;
    dc = det(Ac);

    Ad = A;
    Ad(:,3) = y;
    dd = det(Ad);

    Ae = A;
    Ae(:,4) = y;
    de = det(Ae);


    B = db / d;
    C = dc / d;
    D = dd / d;
    E = de / d;


    Na = na * 1e-10;
    Nk = 2 * pi * sqrt(2 * 1.673e-27 * 1.6e-19) / 6.626e-34;
    display(Nk);

    p = double(subs(B, {a, k}, {Na, Nk}));
    q = double(subs(C, {a, k}, {Na, Nk}));
    r = double(subs(D, {a, k}, {Na, Nk}));
    s = double(subs(E, {a, k}, {Na, Nk}));
end