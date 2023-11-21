clear all
close all
clc

%% Reference trajectory

% Double lane change
Xr=linspace(0,400,20000)';
Yr=interp1([0 125 150 225 250 400],[0 0 3.5 3.5 0 0],Xr);
Yr=smoothdata(Yr,2000,'lowess');

psir=[atan2(diff(Yr),diff(Xr));0];
refPoses=[Xr,Yr,psir];

figure(1)
grid on, box on, hold on
plot(refPoses(:,1),refPoses(:,2),'k','linewidth',0.8)

%return

%% VSC controllers

[Ka,O]=controller_observer_design;
KM=Ka*4e3;
J=4e3;

%% Simulations

% Initial conditions
X0=refPoses(1,1);
Y0=refPoses(1,2);
psi0=refPoses(1,3);
vx0=80/3.6;
vy0=0;
wpsi0=0;
ze0=[X0;Y0;psi0;vx0;vy0;wpsi0];

% Other simulation parameters
trl=sum(sqrt(diff(Xr).^2+diff(Yr).^2));  % lenght of the ref trajectory
Tfin=trl/vx0;
Ts=0.05;    % data sampling time
c_ref=1;    % enables the eta reference generator
csi=0.6;    % friction coefficient

nfile='sim_vsc_obs';
open(nfile)
%return

for i=1:2
    
switch i
case 1
    col=[0 0.6 0];
case 2
    col='r'; 
    KM=KM*0;    % VSC switch-off 
end

sim(nfile)

RMS_ey=rms(errors.data(:,1))
RMS_epsi=rms(errors.data(:,2))

gen_fig

end

%return

%%

figure(1)
ll(1)=legend('reference trajectory','full VSC','no VSC','location','southwest');
xlim([min(Xr) max(Xr)])
ylim([-2.5 5])

figure(2)
subplot(211)
ll(2)=legend('full VSC','no VSC','location','southeast');
set(ll,'fontsize',10)
ylim([-0.5 0.5])
subplot(212)
ylim([-6 6])



