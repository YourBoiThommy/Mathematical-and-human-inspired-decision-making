%% Plot results
close all;

% Time vector
t = 0:N_steps-1;

% Initialize arrays to store results
x_results = zeros(2, N_steps);
u_results = zeros(1, N_steps);

% Initialize state
x_k = x0;

for i = 1:N_steps
    % Optimal control input
    u_k = K*x_k;

    % Apply first input to the system
    x_k = A2*x_k + B2*u_k;
    
    % Store results
    x_results(:, i) = x_k;
    u_results(i) = u_k;
end

figure;
subplot(2, 1, 1);
plot(t, x_results(1, :), 'b', 'LineWidth', 1.5);
hold on;
plot(t, x_results(2, :), 'r', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('State Value');
title('State Evolution');
legend('x_1', 'x_2');
grid on;

[ts,us] = stairs(t,u_results);
subplot(2, 1, 2);
plot(ts, us, 'k', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('Control Input');
title('Control Input Evolution');
grid on;

%% Excercise 1.7:
clc;
clear;

% Time Step and Seconds
k = 1;
N_steps = 400;

% Define system matrices
A2 = [4/3, -2/3; 1, 0];
B2 = [1; 0];
C2 = eye(2);
D2 = 0;

% Define initial condition
x0 = [10; 0];

% Cost matrices
Q = [4/9 + 0.001, -2/3; -2/3, 1.001];
R = 0.001;

% Define prediction horizon and control horizon
Np = 5;

% Perform Backward Riccati iteration
P = Q;
for k = Np:-1:1
    K = -inv(B2.'*P*B2 + R)*B2.'*P*A2;
    P = Q + A2.'*P*(A2 + B2*K);
end

% Feedback matrix
% K = [-0.0256, 0.6654];

%% Excercise 1.8:
% Define prediction horizon and control horizon
Np = 7;

% Perform Backward Riccati iteration
P = Q;
for k = Np:-1:1
    K = -inv(B2.'*P*B2 + R)*B2.'*P*A2;
    P = Q + A2.'*P*(A2 + B2*K);
end
