X = 0:0.05:10;
Y = 0:0.10:30;

%% Exercise 1.1
syms x
syms in1(x) in2(x) in3(x);

pw1     = piecewise(x <= 0,0,(0 < x) & (x <= 2.2),(x/2.2),0);
pw2     = piecewise((2.2 < x) & (x <= 3.4),1,...
                   (3.4 < x) & (x <= 5.6),(5.6-x)/(5.6-3.4),0);
in1(x)  = pw1+pw2;

pw1     = piecewise(x <= 2.2,0,(2.2 < x) & (x <= 4.4),((x-2.2)/(4.4-2.2)),0);
pw2     = piecewise((4.4 < x) & (x <= 5.6),1,...
                   (5.6 < x) & (x <= 7.8),(7.8-x)/(7.8-5.6),0);
in2(x)  = pw1+pw2;

pw1     = piecewise(x <= 4.4,0,(4.4< x) & (x <= 6.6),((x-4.4)/(6.6-4.4)),0);
pw2     = piecewise((6.6 < x) & (x <= 7.8),1,...
                   (7.8 < x) & (x <= 10),(10-x)/(10-7.8),0);
in3(x)  = pw1+pw2;

in1_disc = double(subs(in1(x),x,X));
in2_disc = double(subs(in2(x),x,X));
in3_disc = double(subs(in3(x),x,X));
input = [in1_disc;in2_disc;in3_disc];

% Defining the trapezoidal output functions
syms y 
syms out1(y) out2(y) out3(y);

pw1      = piecewise(y <= 0,0,(0 < y) & (y <= 3),(y/3),0);
pw2      = piecewise((3 < y) & (y <= 9),1,...
                    (9 < y) & (y <= 12),(12-y)/(12-9),0);
out1(y)  = pw1+pw2;

pw1      = piecewise(y <= 9,0,(9 < y) & (y <= 12),((y-9)/(12-9)),0);
pw2      = piecewise((12 < y) & (y <= 18),1,...
                    (18 < y) & (y <= 21),(21-y)/(21-18),0);
out2(y)  = pw1+pw2;

pw1      = piecewise(y <= 18,0,(18 < y) & (y <= 21),((y-18)/(21-18)),0);
pw2      = piecewise((21 < y) & (y <= 27),1,...
                    (27 < y) & (y <= 30),(30-y)/(30-27),0);
out3(y)  = pw1+pw2;

out1_disc = double(subs(out1(y),y,Y));
out2_disc = double(subs(out2(y),y,Y));
out3_disc = double(subs(out3(y),y,Y));
output = [out1_disc;out2_disc;out3_disc];

%% Computing fuzzy relations
close all

R1_mam  = zeros(length(input),length(output));
R1_lars = zeros(length(input),length(output));
R1_KD   = zeros(length(input),length(output));

for i = 1:length(output)
    for j = 1:length(input)
        Mamdami = min(input(1, j),output(1, i));
        Larsen  = input(1, j)*output(1, i);
        KD      = max(1-input(1, j),output(1, i));

        R1_mam(j,i)     = Mamdami;
        R1_lars(j,i)    = Larsen;
        R1_KD(j,i)      = KD;
    end
end

% Plotting input functions
figure;
subplot(2,1,1);
plot(X, in1_disc, 'b', X, in2_disc, 'g', X, in3_disc, 'r');
xlabel('x');
ylabel('Input');
title('Trapezoidal Input Functions');
legend('Input 1', 'Input 2', 'Input 3');

% Plotting output functions
subplot(2,1,2);
plot(Y, out1_disc, 'b', Y, out2_disc, 'g', Y, out3_disc, 'r');
xlabel('y');
ylabel('Output');
title('Trapezoidal Output Functions');
legend('Output 1', 'Output 2', 'Output 3');

% Plotting fuzzy relations
figure;
subplot(1,3,1);
imagesc(R1_mam);
xlabel('Output');
ylabel('Input');
title('Mamdani Fuzzy Relations');
colorbar;

subplot(1,3,2);
imagesc(R1_lars);
xlabel('Output');
ylabel('Input');
title('Larsen Fuzzy Relations');
colorbar;

subplot(1,3,3);
imagesc(R1_KD);
xlabel('Output');
ylabel('Input');
title('Kleene-Dienes Fuzzy Relations');
colorbar;
%% Exercise 1.2


