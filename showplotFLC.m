% All plots are collected here. 
% Comment/Uncomment to obtain plots of interest, or run by section.

%% Exercise 1.1
% Surface plots
figure(1);
surf(R1_mam','FaceAlpha', 0.8,'Edgecolor','none');
xlabel('x');
ylabel('y');
zlabel('\mu');

figure(2);
surf(R1_lars','FaceAlpha', 0.8,'Edgecolor','none');
xlabel('x');
ylabel('y');
zlabel('\mu');

figure(3);    
surf(R1_KD','FaceAlpha', 0.8,'Edgecolor','none');
xlabel('x');
ylabel('y');
zlabel('\mu');

%% Exercise 1.2
% Plotting Bad and Acceptable fuzzy sets for x
figure(4);
fplot([in1(x),in2(x)]);
xlim([0,10]);
xlabel('x');
ylabel('\mu')
legend('Bad','Acceptable');

% Plotting intersection including coords of first intersection

% ##### WIP - need to double check intersection plot #####

figure(5);
surf(Z1','FaceAlpha', 1,'Edgecolor','none','FaceColor','[0 0.9 0]');
hold on
surf(repmat(in2_disc,length(in2_disc),1),'FaceAlpha', 0.25,...
    'Edgecolor','none','FaceColor', 'r');
surf(R1_mam','FaceAlpha', 0.25,'Edgecolor','none','FaceColor','b');
plot3(interrow*ones(size(intercol)),intercol,...
    Z1(interrow,intercol),'magentao','MarkerSize', 5);
hold off
axis tight;
xlabel('x');
ylabel('y');
zlabel('\mu');
legend('Intersection','Acceptable','R1')
title('Surface Plot of Intersection between Acceptable Set and R1')

% Plotting output fuzzy set
figure(6);
plot(outZ1);
xlabel('y');
ylabel('\mu');
title('Output Fuzzy Set');

%% Exercise 1.3
% Plotting relations corresponding to R2 and R3
figure(7);
surf(R1_mam','FaceAlpha', 0.4,'Edgecolor','none','FaceColor','r');
hold on
surf(R2_mam','FaceAlpha', 0.4,'Edgecolor','none','FaceColor','[0 0.55 0]');
surf(R3_mam','FaceAlpha', 0.4,'Edgecolor','none','FaceColor','b');
hold off
axis tight;
xlabel('x');
ylabel('y');
zlabel('\mu');
legend('R1','R2','R3')
title('Fuzzy Relations corresponding to R1, R2, R3');

% Plotting rule base B obtained using conjunction
figure(8);
surf(B_cra','FaceAlpha', 0.75,'Edgecolor','none');
axis tight;
xlabel('x');
ylabel('y');
zlabel('\mu');
title('Rule Base B Resulting from Conjunction Rule Aggregation');

%% Exercise 1.4
% Plotting intersection rule base B and input fuzzy sets
figure(9);
surf(B_cra','FaceAlpha', 0.4,'Edgecolor','none');
hold on
surf(repmat(fuzzy_ston(1,:),301,1),'FaceAlpha', ...
    0.8,'Edgecolor','none','FaceColor','r');
surf(repmat(fuzzy_ston(2,:),301,1),'FaceAlpha', ...
    0.4,'Edgecolor','none','FaceColor','[0 0.55 0]');
surf(repmat(fuzzy_ston(3,:),301,1),'FaceAlpha', ...
    0.9,'Edgecolor','none','FaceColor','magenta');
hold off
axis tight;
xlabel('x');
ylabel('y');
zlabel('\mu');
% legend('B','R1','R2','R3');
title('Intersection Rule Base B and Input Fuzzy Sets');
