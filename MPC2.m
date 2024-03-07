%% Plot results
close all;

A_tilde = [];
G_tilde = [];
for i = 1:Np
    A_tilde = [A_tilde; A^i];
    G_tilde = [G_tilde; G];
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
E_tilde = [];
F_tilde = [];
for i = 1:Np
    Ri = [];
    Qi = [];
    Ei = [];
    Fi = [];
    for j = 1:Np
        if i-j == 0
            Rij = R;
            Qij = Q;
            Eij = E;
            Fij = F;
        else
            Rij = zeros(size(R));
            Qij = zeros(size(Q));
            Eij = zeros(size(E));
            Fij = zeros(size(F));
        end
        if i == Np & j == Np
            Qij = Qij + Qf;
        end
        Ri = [Ri Rij];
        Qi = [Qi Qij];
        Ei = [Ei Eij];
        Fi = [Fi Fij];
    end
    R_tilde = [R_tilde; Ri];
    Q_tilde = [Q_tilde; Qi];
    E_tilde = [E_tilde; Ei];
    F_tilde = [F_tilde; Fi];
end

Aineq = E_tilde + F_tilde*B_tilde;

H = B_tilde.'*Q_tilde*B_tilde + R_tilde;

% Time vector
t = 0:N_steps-1;

% Initialize arrays to store results
x_results = zeros(2, N_steps);
u_results = zeros(1, N_steps);

% Initialize state
xk = x0;

% Quadprog options
options = optimoptions('quadprog', 'Display', 'final');
warning('off', 'all');

for i = 1:N_steps
    bineq = G_tilde - F_tilde*A_tilde*xk;
    f = 2*xk.'*A_tilde.'*Q_tilde*B_tilde;
    %c = xk.'*A_tilde.'*Q_tilde*A_tilde*xk;
    u_pred = quadprog(H,f,Aineq,bineq,[],[],[],[],[],options);
    uk = u_pred(1);
    xk = A*xk + B*uk;

    % Store results
    x_results(:, i) = xk;
    u_results(i) = uk;
end
warning('on', 'all');

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
Qf = zeros(2);

E = [0; 0];
F = [0 0; 0 0];
G = [0; 0];

%% Excercise 2.2:
Q = [100 0; 0 1];

%% Excercise 2.3:
E = [1; -1];
F = [0 0; 0 0];
G = [1; 1];

%% Excercise 2.4:
E = [1; -1; 0];
F = [0 0; 0 0; -1 0];
G = [1; 1; 2];

%% Excercise 2.5:
Np = 100;

%% Exercise 2.6: 
Np = 10;
Qf = [1 0; 0 1];
