% All plots are collected here. 
% Comment/Uncomment to obtain plots of interest, or run by section.

%% Exercise 1.1
% Surface plots
figure(1);
surf(R1_mam','FaceAlpha', 0.8,'Edgecolor','none');
xlabel('x');
ylabel('y');
zlabel('\mu');
xticklabels(0:2.5:10);
xlim([0,201]);
yticklabels(0:10:30);
xlim([0,301]);

figure(2);
surf(R1_lars','FaceAlpha', 0.8,'Edgecolor','none');
xlabel('x');
ylabel('y');
zlabel('\mu');
xticklabels(0:2.5:10);
xlim([0,201]);
yticklabels(0:10:30);
xlim([0,301]);

figure(3);    
surf(R1_KD','FaceAlpha', 0.8,'Edgecolor','none');
xlabel('x');
ylabel('y');
zlabel('\mu');
xticklabels(0:2.5:10);
xlim([0,201]);
yticklabels(0:10:30);
xlim([0,301]);

%% Exercise 1.2
% Plotting Bad and Acceptable fuzzy sets for x
figure(4);
fplot([in1(x),in2(x)]);
xlim([0,10]);
xlabel('x');
ylabel('\mu')
legend('Bad','Acceptable');

% Plotting intersection including coords of first intersection
figure(5);
surf(Z1','FaceAlpha', 1,'Edgecolor','none','FaceColor','[0 0.9 0]');
hold on
surf(repmat(in2_disc,length(in2_disc),1),'FaceAlpha', 0.25,...
    'Edgecolor','none','FaceColor', 'r');
surf(R1_mam','FaceAlpha', 0.25,'Edgecolor','none','FaceColor','b');
plot3(interrow*ones(size(intercol)),intercol,...
    Z1(interrow,intercol),'magentao','MarkerSize', 5);
hold off
xticklabels(0:2.5:10);
xlim([0,201]);
yticklabels(0:10:30);
xlim([0,301]);
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
xticklabels(0:5:30);
xlim([0,301]);

%% Exercise 1.3
% Plotting relations corresponding to R2 and R3
figure(7);
surf(R1_mam','FaceAlpha', 0.4,'Edgecolor','none','FaceColor','r');
hold on
surf(R2_mam','FaceAlpha', 0.4,'Edgecolor','none','FaceColor','[0 0.55 0]');
surf(R3_mam','FaceAlpha', 0.4,'Edgecolor','none','FaceColor','b');
hold off
xticklabels(0:2.5:10);
xlim([0,201]);
yticklabels(0:10:30);
xlim([0,301]);
axis tight;
xlabel('x');
ylabel('y');
zlabel('\mu');
legend('R1','R2','R3')
title('Fuzzy Relations corresponding to R1, R2, R3');

% Plotting rule base B obtained using conjunction
figure(8);
surf(B_cra','FaceAlpha', 0.75,'Edgecolor','none');
xticklabels(0:2.5:10);
xlim([0,201]);
yticklabels(0:10:30);
xlim([0,301]);
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
surf(repmat(fuzzy_ston,301,1),'FaceAlpha', ...
    0.6,'Edgecolor','none','FaceColor','r');
hold off
xticklabels(0:2.5:10);
xlim([0,201]);
yticklabels(0:10:30);
xlim([0,301]);
axis tight;
xlabel('x');
ylabel('y');
zlabel('\mu');
% legend('B','R1','R2','R3');
title('Intersection Rule Base B and Input Fuzzy Sets');

% Plotting output fuzzy set
figure(10);
plot(mu_B,'LineWidth',1.5);
hold on
xline(y_cog/0.10, 'k--', 'LineWidth',1.5,'Color','red'); 
xline(y_mom/0.10, 'k--', 'LineWidth',1.5,'Color','[0 0.55 0]');  
xlabel('y');
ylabel('\mu');
title('Output fuzzy set');
xticklabels(0:5:30);
xlim([0,301]);
legend('\mu_B','y_{CoG}','y_{MoM}');
