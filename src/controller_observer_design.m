function [K,O]=controller_observer_design

vx=110/3.6;
Q=diag([100 10]);
R=1;

%% DSTbeta model

% Model parameters
lf=1.2;     % m
lr=1.6;     % m
m=1575;     % kg
J=4000;     % kg*m^2
cf=27e3;    % N/rad
cr=20e3;    % N/rad
c1=-2*(cf+cr);
c2=-2*(cf*lf-cr*lr);
c3=-2*(cf*lf^2+cr*lr^2);

% Model matrices
Aeta=[c1/m/vx -1+c2/m/vx^2; c2/J c3/J/vx];
Ba=[0;1];
Bs=[2*cf/m/vx;2*cf*lf/J];

%% Controller design

Mc=ctrb(Aeta,Ba);
rank(Mc)

K=lqr(Aeta,Ba,Q,R); 

eig(Aeta-Ba*K)

%% Observer desing

C=[0 1];
Mo=obsv(Aeta,C);
rank(Mo)

la=eig(Aeta-Ba*K);
lo=[1.5*real(la(1)) 2*real(la(1))];

L=place(Aeta',C',lo)';

O=ss(Aeta-L*C,[L Bs Ba],eye(2),0);



