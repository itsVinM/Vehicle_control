
%% Figures

fs=14;
lw1=1;

fig1=figure(1);
plot(ze.data(:,1),ze.data(:,2),'-','color',col,'linewidth',lw1)
xlabel('X [m]')
ylabel('Y [m]')

fig2=figure(2);
subplot(211)
grid on, box on, hold on
plot(errors.time,errors.data(:,1),'-','color',col,'linewidth',lw1)
xlabel('time [s]','interpreter','latex','fontsize',fs)
ylabel('lateral error [m]','interpreter','latex','fontsize',fs)
xlim([0 Tfin])
subplot(212)
grid on, box on, hold on
plot(errors.time,errors.data(:,2)*180/pi,'-','color',col,'linewidth',lw1)
xlabel('time [s]','interpreter','latex','fontsize',fs)
ylabel('orientation error [deg]','interpreter','latex','fontsize',fs)
xlim([0 Tfin])
