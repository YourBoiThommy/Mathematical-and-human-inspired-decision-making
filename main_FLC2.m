% Please note: it is recommended to run by section
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

%% Exercise 2.2

x1cr = 1/dt1;
x2cr = 370/dt2;       % [kg]
x3cr = 7.2/dt3;       % [mm/hr]

% Estimating membership degrees
mu_x1   = inx1(:,x1cr);
mu_x2   = inx2(:,x2cr);
mu_x3   = inx3(:,x3cr);

% Constructing logical connectives for antecedents
R10m    = mu_x1(3);
R13m    = max(max(mu_x1(1),mu_x2(3)),mu_x3(3));
R6m     = min(mu_x2(3),mu_x3(2));
R9m     = min(mu_x2(3),mu_x3(3));

ZR10    = zeros(1,length(out2_disc));
ZR13    = zeros(1,length(out1_disc));
ZR6     = zeros(1,length(out2_disc));
ZR9     = zeros(1,length(out1_disc));
for i = 1:length(out4_disc)
    ZR10(i) = min(R10m,out2_disc(i));
    ZR13(i) = min(R13m,out1_disc(i));
    ZR6(i)  = min(R6m,out2_disc(i));
    ZR9(i)  = min(R9m,out1_disc(i));
end

mu_B = zeros(1,length(ZR10));
for i = 1:length(mu_B)
    mu_B(i) = max(max(max(ZR10(i),ZR13(i)),ZR6(i)),ZR9(i));
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

%% Exercise 2.3
% Creating system
fis = mamfis("Name","velocity");

% Adding input variables
fis = addInput(fis,[0 10],"Name","road quality");
fis = addInput(fis,[0 390],"Name","car load");
fis = addInput(fis,[0 15],"Name","rain intensity");

% Adding input membership functions
fis = addMF(fis,"road quality","trapmf",[0 2.2 3.4 5.6],"Name","bad");
fis = addMF(fis,"road quality","trapmf",[2.2 4.4 5.6 7.8],"Name","acceptable");
fis = addMF(fis,"road quality","trapmf",[4.4 6.6 7.8 10],"Name","good");

fis = addMF(fis,"car load","trapmf",[0 45 115 160],"Name","low");
fis = addMF(fis,"car load","trapmf",[115 160 230 275],"Name","average");
fis = addMF(fis,"car load","trapmf",[230 275 345 390],"Name","high");

fis = addMF(fis,"rain intensity","trapmf",[0 1 2 3],"Name","light");
fis = addMF(fis,"rain intensity","trapmf",[2 3 7 8],"Name","moderate");
fis = addMF(fis,"rain intensity","trapmf",[7 8 14 15],"Name","heavy");

% Adding output variable
fis = addOutput(fis,[0 30],"Name","car speed");

% Adding output membership functions
fis = addMF(fis,"car speed","trapmf",[0 2.5 5.5 8],"Name","very slow");
fis = addMF(fis,"car speed","trapmf",[5.5 8 11 13.5],"Name","slow");
fis = addMF(fis,"car speed","trapmf",[11 13.5 16.5 19],"Name","medium");
fis = addMF(fis,"car speed","trapmf",[16.5 19 22 24.5],"Name","fast");
fis = addMF(fis,"car speed","trapmf",[22 24.5 27.5 30],"Name","very fast");

% Defining rule list
ruleList = [0 1 1 5 1 1;
            0 2 1 4 1 1;
            0 3 1 3 1 1;
            0 1 2 4 1 1;
            0 2 2 3 1 1;
            0 3 2 2 1 1;
            0 1 3 2 1 1;
            0 2 3 2 1 1;
            0 3 3 1 1 1;
            1 0 0 2 1 1;
            2 0 0 3 1 1;
            3 0 0 4 1 1;
            1 3 3 1 1 2];

% Adding rules to the FIS
fis = addRule(fis,ruleList);

% At this point, the application may be used for analysis

% Plotting aggregated- and crisp outputs from evalfis
% Uncomment the one of the two input sets in evalfis you're interested in
inputs = [8 130 4;
          1 370 7.2;]
evalfis(fis,inputs)

[output,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(fis,inputs(1,:));
% [output,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(fis,inputs(2,:));
outputRange = linspace(fis.output.range(1),fis.output.range(2),length(aggregatedOut))'; 
plot(outputRange,aggregatedOut,[output output],[0 1])

%% Exercise 2.4
inputs = [8 180 9;
          9 180 9;]
evalfis(fis,inputs)

[output,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(fis,inputs(1,:));
% [output,fuzzifiedIn,ruleOut,aggregatedOut,ruleFiring] = evalfis(fis,inputs(2,:));
outputRange = linspace(fis.output.range(1),fis.output.range(2),length(aggregatedOut))'; 
plot(outputRange,aggregatedOut,[output output],[0 1])
