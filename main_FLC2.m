% Define domains
dt1 = 0.05;
dt2 = 1;
dt3 = 0.05;
dty = 0.10;

X1  = 0:dt1:10;
X2  = 0:dt2:390;
X3  = 0:dt3:15;
Y   = 0:dty:30;

% Defining the trapezoidal input functions
syms x1
syms in11(x1) in12(x1) in13(x1);

pw1     = piecewise(x1 <= 0,0,(0 < x1) & (x1 < 2.2),(x1/2.2),0);
pw2     = piecewise((2.2 <= x1) & (x1 < 3.4),1,...
                   (3.4 <= x1) & (x1 < 5.6),(5.6-x1)/(5.6-3.4),0);
in11(x1)  = pw1+pw2;

pw1     = piecewise(x1 <= 2.2,0,(2.2 < x1) & (x1 < 4.4), ...
                   ((x1-2.2)/(4.4-2.2)),0);
pw2     = piecewise((4.4 <= x1) & (x1 < 5.6),1,...
                   (5.6 <= x1) & (x1 < 7.8),(7.8-x1)/(7.8-5.6),0);
in12(x1)  = pw1+pw2;

pw1     = piecewise(x1 <= 4.4,0,(4.4< x1) & (x1 < 6.6), ...
                   ((x1-4.4)/(6.6-4.4)),0);
pw2     = piecewise((6.6 <= x1) & (x1 < 7.8),1,...
                   (7.8 <= x1) & (x1 < 10),(10-x1)/(10-7.8),0);
in13(x1)  = pw1+pw2;

in11_disc   = double(subs(in11(x1),x1,X1));
in12_disc   = double(subs(in12(x1),x1,X1));
in13_disc   = double(subs(in13(x1),x1,X1));
inx1        = [in11_disc;in12_disc;in13_disc];

syms x2
syms in21(x2) in22(x2) in23(x2);

pw1     = piecewise(x2 <= 0,0,(0 < x2) & (x2 < 45),(x2/45),0);
pw2     = piecewise((45 <= x2) & (x2 < 115),1,...
                   (115 <= x2) & (x2 < 160),(160-x2)/(160-115),0);
in21(x2)  = pw1+pw2;

pw1     = piecewise(x2 <= 115,0,(115 < x2) & (x2 < 160), ...
                   ((x2-115)/(160-115)),0);
pw2     = piecewise((160 <= x2) & (x2 < 230),1,...
                   (230 <= x2) & (x2 < 275),(275-x2)/(275-230),0);
in22(x2)  = pw1+pw2;

pw1     = piecewise(x2 <= 230,0,(230< x2) & (x2 < 275), ...
                   ((x2-230)/(275-230)),0);
pw2     = piecewise((275 <= x2) & (x2 < 345),1,...
                   (345 <= x2) & (x2 < 390),(390-x2)/(390-345),0);
in23(x2)  = pw1+pw2;

in21_disc   = double(subs(in21(x2),x2,X2));
in22_disc   = double(subs(in22(x2),x2,X2));
in23_disc   = double(subs(in23(x2),x2,X2));
inx2        = [in21_disc;in22_disc;in23_disc];

syms x3
syms in31(x3) in32(x3) in33(x3);

pw1     = piecewise(x3 <= 0,0,(0 < x3) & (x3 < 1),(x3/1),0);
pw2     = piecewise((1 <= x3) & (x3 < 2),1,...
                   (2 <= x3) & (x3 < 3),(3-x3)/(3-2),0);
in31(x3)  = pw1+pw2;

pw1     = piecewise(x3 <= 2,0,(2 < x3) & (x3 < 3), ...
                   ((x3-2)/(3-2)),0);
pw2     = piecewise((3 <= x3) & (x3 < 7),1,...
                   (7 <= x3) & (x3 < 8),(8-x3)/(8-7),0);
in32(x3)  = pw1+pw2;

pw1     = piecewise(x3 <= 7,0,(7< x3) & (x3 < 8), ...
                   ((x3-7)/(8-7)),0);
pw2     = piecewise((8 <= x3) & (x3 < 14),1,...
                   (14 <= x3) & (x3 < 15),(15-x3)/(15-14),0);
in33(x3)  = pw1+pw2;

in31_disc   = double(subs(in31(x3),x3,X3));
in32_disc   = double(subs(in32(x3),x3,X3));
in33_disc   = double(subs(in33(x3),x3,X3));
inx3        = [in31_disc;in32_disc;in33_disc];

% Adjust vars and values to check where necessary
% fplot([in31(x3),in32(x3),in33(x3)]);
% xlim([0,15])

% Defining the trapezoidal output functions
syms y 
syms out1(y) out2(y) out3(y) out4(y) out5(y);

pw1      = piecewise(y <= 0,0,(0 < y) & (y < 2.5),(y/2.5),0);
pw2      = piecewise((2.5 <= y) & (y < 5.5),1,...
                    (5.5 <= y) & (y < 8),(8-y)/(8-5.5),0);
out1(y)  = pw1+pw2;

pw1      = piecewise(y <= 5.5,0,(5.5 < y) & (y < 8),((y-5.5)/(8-5.5)),0);
pw2      = piecewise((8 <= y) & (y < 11),1,...
                    (11 <= y) & (y < 13.5),(13.5-y)/(13.5-11),0);
out2(y)  = pw1+pw2;

pw1      = piecewise(y <= 11,0,(11 < y) & (y < 13.5),((y-11)/(13.5-11)),0);
pw2      = piecewise((13.5 <= y) & (y < 16.5),1,...
                    (16.5 <= y) & (y < 19),(19-y)/(19-16.5),0);
out3(y)  = pw1+pw2;

pw1      = piecewise(y <= 16.5,0,(16.5 < y) & (y < 19),((y-16.5)/(19-16.5)),0);
pw2      = piecewise((19 <= y) & (y < 22),1,...
                    (22 <= y) & (y < 24.5),(24.5-y)/(24.5-22),0);
out4(y)  = pw1+pw2;

pw1      = piecewise(y <= 22,0,(22 < y) & (y < 24.5),((y-22)/(24.5-22)),0);
pw2      = piecewise((24.5 <= y) & (y < 27.5),1,...
                    (27.5 <= y) & (y < 30),(30-y)/(30-27.5),0);
out5(y)  = pw1+pw2;

out1_disc   = double(subs(out1(y),y,Y));
out2_disc   = double(subs(out2(y),y,Y));
out3_disc   = double(subs(out3(y),y,Y));
out4_disc   = double(subs(out4(y),y,Y));
out5_disc   = double(subs(out5(y),y,Y));
output      = [out1_disc;out2_disc;out3_disc;out4_disc;out5_disc];

% Adjust vars and values to check where necessary
% fplot([out1(y),out2(y),out3(y),out4(y),out5(y)]);
% fplot(out1(y));
% xlim([0,30])

%% Exercise 2.1

x1cr = 8/dt1;
x2cr = 130/dt2;     % [kg]
x3cr = 4/dt3;       % [mm/hr]

% Performing fuzzification of each input using Singleton
mu_x1ston = zeros(1,length(inx1));
mu_x2ston = zeros(1,length(inx2));
mu_x3ston = zeros(1,length(inx3));
mu_x1ston(x1cr) = 1;
mu_x2ston(x2cr) = 1;
mu_x3ston(x3cr) = 1;

% Estimating membership degrees
mu_x1   = inx1(:,x1cr);
mu_x2   = inx2(:,x2cr);
mu_x3   = inx3(:,x3cr);

% figure(1);
% fplot([in11,in12,in13]);
% xlim([0,10]);
% hold on
% xline(x1cr*dt1, 'k--', 'LineWidth',1.5,'Color','red'); 
% hold off
% legend('Bad','Acceptable','Good');
% 
% figure(2);
% fplot([in21,in22,in23]);
% xlim([0,390]);
% hold on
% xline(x2cr*dt2, 'k--', 'LineWidth',1.5,'Color','red'); 
% hold off
% legend('Low','Average','High');
% 
% figure(3);
% fplot([in31,in32,in33]);
% xlim([0,15]);
% hold on
% xline(x3cr*dt3, 'k--', 'LineWidth',1.5,'Color','red'); 
% hold off
% legend('Light','Moderate','Heavy');

% % For clarity's sake putting them both next to each other (R4)
% figure(4);
% subplot(1,2,1);
% fplot([in21,in22,in23]);
% xlim([0,390]);
% hold on
% xline(x2cr*dt2, 'k--', 'LineWidth',1.5,'Color','red'); 
% hold off
% xlabel('x_2')
% ylabel('\mu')
% legend('Low','Average','High');
% 
% subplot(1,2,2);
% fplot([in31,in32,in33]);
% xlim([0,15]);
% hold on
% xline(x3cr*dt3, 'k--', 'LineWidth',1.5,'Color','red'); 
% hold off
% xlabel('x_3')
% ylabel('\mu')
% legend('Light','Moderate','Heavy');

% From plots, rules R4, R5, and R12 are fired
% Taking minima between inputs

R12m    = mu_x1(3);
R4m     = min(mu_x2(1),mu_x3(2));
R5m     = min(mu_x2(2),mu_x3(2));

ZR12    = zeros(1,length(out4_disc));
ZR4     = zeros(1,length(out4_disc));
ZR5     = zeros(1,length(out5_disc));
for i = 1:length(out4_disc)
    ZR12(i) = min(R12m,out4_disc(i));
    ZR4(i)  = min(R4m,out4_disc(i));
    ZR5(i)  = min(R5m,out3_disc(i));
end

mu_B = zeros(1,length(ZR4));
for i = 1:length(mu_B)
    mu_B(i) = max(max(ZR12(i),ZR4(i)),ZR5(i));
end

y_cog   = (sum(Y.*mu_B))/(sum(mu_B));
max_muB = max(mu_B);
coreB   = find(mu_B == max_muB);
y_mom   = ((coreB(1)+coreB(end))/2)*dty;

plot(Y,mu_B);
hold on
xline(y_cog, 'k--', 'LineWidth',1.5,'Color','red','Label','y_{CoG}'); 
xline(y_mom, 'k--', 'LineWidth',1.5,'Color','red','Label','y_{MoM}'); 
hold off
xlabel('y');
ylabel('\mu');
title('Aggregated output');

% plot(Y,output);
% hold on
% plot(Y, ZR4);
% plot(Y, ZR5);
% yline(R4m, 'k', 'LineWidth',2,'Color','[0.9 0 0]');
% yline(R5m, 'k', 'LineWidth',2,'Color','[0 0.5 0]');
% xlabel('y');
% ylabel('\mu');
% hold off
