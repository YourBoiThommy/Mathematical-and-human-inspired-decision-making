%% Project 2 Math HI Decision Making: Steering a Car using FLC

% Change plotflag to 1 if you would like to see plots
% Refer to showplotFLC function for more info
plotflag = 0;
if plotflag == 1
    showplotFLC;
else
    disp('Plots will not be displayed.');
end

% Define domains
X = 0:0.05:10;
Y = 0:0.10:30;

%% Exercise 1.1
% Defining the trapezoidal input functions
syms x
syms in1(x) in2(x) in3(x);

pw1     = piecewise(x <= 0,0,(0 < x) & (x < 2.2),(x/2.2),0);
pw2     = piecewise((2.2 <= x) & (x < 3.4),1,...
                   (3.4 <= x) & (x < 5.6),(5.6-x)/(5.6-3.4),0);
in1(x)  = pw1+pw2;

pw1     = piecewise(x <= 2.2,0,(2.2 < x) & (x < 4.4),((x-2.2)/(4.4-2.2)),0);
pw2     = piecewise((4.4 <= x) & (x < 5.6),1,...
                   (5.6 <= x) & (x < 7.8),(7.8-x)/(7.8-5.6),0);
in2(x)  = pw1+pw2;

pw1     = piecewise(x <= 4.4,0,(4.4< x) & (x < 6.6),((x-4.4)/(6.6-4.4)),0);
pw2     = piecewise((6.6 <= x) & (x < 7.8),1,...
                   (7.8 <= x) & (x < 10),(10-x)/(10-7.8),0);
in3(x)  = pw1+pw2;

in1_disc = double(subs(in1(x),x,X));
in2_disc = double(subs(in2(x),x,X));
in3_disc = double(subs(in3(x),x,X));
input = [in1_disc;in2_disc;in3_disc];

% Defining the trapezoidal output functions
syms y 
syms out1(y) out2(y) out3(y);

pw1      = piecewise(y <= 0,0,(0 < y) & (y < 3),(y/3),0);
pw2      = piecewise((3 <= y) & (y < 9),1,...
                    (9 <= y) & (y < 12),(12-y)/(12-9),0);
out1(y)  = pw1+pw2;

pw1      = piecewise(y <= 9,0,(9 < y) & (y < 12),((y-9)/(12-9)),0);
pw2      = piecewise((12 <= y) & (y < 18),1,...
                    (18 <= y) & (y < 21),(21-y)/(21-18),0);
out2(y)  = pw1+pw2;

pw1      = piecewise(y <= 18,0,(18 < y) & (y < 21),((y-18)/(21-18)),0);
pw2      = piecewise((21 <= y) & (y < 27),1,...
                    (27 <= y) & (y < 30),(30-y)/(30-27),0);
out3(y)  = pw1+pw2;

out1_disc = double(subs(out1(y),y,Y));
out2_disc = double(subs(out2(y),y,Y));
out3_disc = double(subs(out3(y),y,Y));
output = [out1_disc;out2_disc;out3_disc];

%% Computing fuzzy relations
R1_mam  = zeros(length(input),length(output));
R1_lars = zeros(length(input),length(output));
R1_KD   = zeros(length(input),length(output));

for i = 1:length(output)      
    for j = 1:length(input)
        Mamdami = min(input(1,j),output(1,i));
        Larsen  = input(1,j)*output(1,i);
        KD      = max(1-input(1,j),output(1,i));

        R1_mam(j,i)     = Mamdami;
        R1_lars(j,i)    = Larsen;
        R1_KD(j,i)      = KD;
    end
end

%% Exercise 1.2
% Computing the intersection
Z1 = zeros(size(R1_mam));

for i = 1:length(in2_disc)
    Z1(i,:) = min(in2_disc(i),R1_mam(i,:));
end

% Finding indices of where intersection occurs first
[interrow,tempcol]   = find(Z1>0,1,'first');
intercol = find(Z1(interrow,:) > 0);

% Computing and plotting output fuzzy set
outZ1 = max(Z1,[],1);

%% Exercise 1.3
% Computing fuzzy relations corresponding to R2 & R3 using Mamdani
R2_mam  = zeros(length(input),length(output));
R3_mam  = zeros(length(input),length(output));

for i = 1:length(output)      
    for j = 1:length(input)
        Mamdami2 = min(input(2,j),output(2,i));
        Mamdami3 = min(input(3,j),output(3,i));

        R2_mam(j,i)     = Mamdami2;
        R3_mam(j,i)     = Mamdami3;
    end
end

% Aggregating three rules using Conjunction Rule Aggregation
B_cra = max(max(R1_mam, R2_mam),R3_mam);

%% Exercise 1.4
crisp_val = 4.7/0.05;
fuzzy_set = input(:,crisp_val);
