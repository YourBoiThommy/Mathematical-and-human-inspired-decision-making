% All plots are collected here. 
% Comment/Uncomment to obtain plots of interest, or run by section.

%% Exercise 1.1
% Surface plots
figure(1);
surf(R1_mam,'FaceAlpha', 0.8,'Edgecolor','none');
xlabel('x');
ylabel('y');
zlabel('\mu');

figure(2);
surf(R1_lars,'FaceAlpha', 0.8,'Edgecolor','none');
xlabel('x');
ylabel('y');
zlabel('\mu');

figure(3);                  % Need to double check this
surf(R1_KD,'FaceAlpha', 0.8,'Edgecolor','none');
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
surf(repmat(in2_disc,length(in2_disc),1),'FaceAlpha', 0.2,...
    'Edgecolor','none','FaceColor', 'r');
hold on
surf(R1_mam,'FaceAlpha', 0.2,'Edgecolor','none','FaceColor','b');
surf(Z1,'FaceAlpha', 0.5,'Edgecolor','none','FaceColor','g')
plot3(interrow*ones(size(intercol)),intercol,...
    Z1(interrow,intercol),'ro','MarkerSize', 4);
hold off
axis tight;
xlabel('x');
ylabel('y');
zlabel('\mu');
legend('Acceptable','R1','Intersection')
title('Surface Plot of Intersection between Acceptable Set and R1')

% Plotting output fuzzy set
figure(6);
plot(outZ1);
xlabel('y');
ylabel('\mu');
title('Output Fuzzy Set');
