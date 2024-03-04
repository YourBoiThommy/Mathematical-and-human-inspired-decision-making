%% Plot results
close all;

A_tilde = [];
for i = 1:Np
    A_power = A^i;
    A_tilde = [A_tilde; A_power];
end

B_tilde = [];
for i = 1:Np
    Bi = [];
    for j = 1:Np
        if i-j < 0
            Bij = zeros(size(B));
        else
            Bij = A^(i-j) * B;
        end
        Bi = [Bi Bij];
    end
    B_tilde = [B_tilde; Bi];
end

R_tilde = [];
Q_tilde = [];
for i = 1:Np
    Ri = [];
    Qi = [];
    for j = 1:Np
        if i-j == 0
            Rij = R;
            Qij = Q;
        else
            Rij = zeros(size(R));
            Qij = zeros(size(Q));
        end
        Ri = [Ri Rij];
        Qi = [Qi Qij];
    end
    R_tilde = [R_tilde; Ri];
    Q_tilde = [Q_tilde; Qi];
end

H = B_tilde.'*Q_tilde*B_tilde + R_tilde;

% Time vector
t = 0:N_steps-1;

% Initialize arrays to store results
x_results = zeros(2, N_steps);
u_results = zeros(1, N_steps);

% Initialize state
xk = x0;

for i = 1:N_steps
    f = 2*xk.'*A_tilde.'*Q_tilde*B_tilde;
    %c = xk.'*A_tilde.'*Q_tilde*A_tilde*xk;
    u_pred = quadprog(H,f);
    uk = u_pred(1);
    xk = A*xk + B*uk;

    % Store results
    x_results(:, i) = xk;
    u_results(i) = uk;
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

%% Excercise 2.1:
clc;
clear;

% Time Step and Seconds
k = 1;
N_steps = 120;

Np = 10;

A = [1 0.1; 0 1];
B = [0; 0.1];
C = eye(2);
D = 0;

x0 = [10; 0];

Q = eye(2);
R = 1;

%% Excercise 2.2:
Q = 100 * eye(2);
