%% Plot results
close all;

%Initialize B tilde matrix
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

%Initialize the other tilde matrices
A_tilde = [];
G_tilde = [];
R_tilde = [];
Q_tilde = [];
E_tilde = [];
F_tilde = [];
for i = 1:Np
    if i == Np
        E_tilde = blkdiag(E_tilde, E + Et);
        F_tilde = blkdiag(F_tilde, F + Ft);
        G_tilde = [G_tilde; G + Gt];
    else
        E_tilde = blkdiag(E_tilde, E);
        F_tilde = blkdiag(F_tilde, F);
        G_tilde = [G_tilde; G];
    end
    A_tilde = [A_tilde; A^i];
    R_tilde = blkdiag(R_tilde, R);
    Q_tilde = blkdiag(Q_tilde, Q);
end

% Constraint matrix
Aineq = E_tilde + F_tilde*B_tilde;

% Hessian cost representation
H = B_tilde.'*Q_tilde*B_tilde + R_tilde;

% Time vector
t = 0:N_steps-1;

% Initialize arrays to store results
x_results = zeros(2, N_steps);
u_results = zeros(1, N_steps);

% Initialize state
xk = x0;
uk = 0;
% Quadprog options
options = optimoptions('quadprog', 'Display', 'off');
warning('off', 'all');

for i = 1:N_steps

    % Store results
    x_results(:, i) = xk;
    u_results(i) = uk;

    % Contraints RHS vector
    bineq = G_tilde - F_tilde*A_tilde*xk;

    % State cost
    f = 2*xk.'*A_tilde.'*Q_tilde*B_tilde;

    % Get next optimal input
    u_pred = quadprog(H,f,Aineq,bineq,[],[],[],[],[],options);
    if size(u_pred, 1) == 0
        disp("Infeasible optimization problem at timestep " + i);
        break
    end

    % Update control input
    uk = u_pred(1);

    % Get next state
    xk = A*xk + B*uk;
end

warning('on', 'all');

% Store final value results
x_results(:, end) = xk;
u_results(end) = uk;


h = figure;

% Plot state evolution
subplot(2, 1, 1);
plot(t, x_results(1, :), 'b', 'LineWidth', 1.5);
hold on;
plot(t, x_results(2, :), 'r', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('State Value');
title('State Evolution');
legend('x_1', 'x_2');
grid on;

% Plot input evolution
[ts,us] = stairs(t,u_results);
subplot(2, 1, 2);
plot(ts, us, 'k', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('Control Input');
title('Control Input Evolution');
grid on;

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'C:\Users\Thoma\Documents\MATLAB\Mathematical\2.2.pdf','-dpdf','-r0')

%% Excercise 2.1:
clc;
clear;

% Time Step and Seconds
k = 1;
N_steps = 160;

Np = 10;

A = [1 0.1; 0 1];
B = [0; 0.1];
C = eye(2);
D = 0;

x0 = [10; 0];

Q = eye(2);
R = 1;

E = 0;
F = [0 0];
G = 0;

Et = 0;
Ft = [0 0];
Gt = 0;

%% Excercise 2.2:
N_steps = 30;

Q = [100 0; 0 1];

%% Excercise 2.3:
N_steps = 200;

E = [1; -1];
F = [0 0; 0 0];
G = [1; 1];

%% Excercise 2.4:
N_steps = 200;

E = [1; -1; 0];
F = [0 0; 0 0; -1 0];
G = [1; 1; 2];

Et = [0; 0; 0];
Ft = [0 0; 0 0; 0 0];
Gt = [0; 0; 0];

%% Excercise 2.5:
N_steps = 100;

Np = 100;

%% Exercise 2.6: 
N_steps = 140;

Np = 10;

E = [1; -1; 0; 0; 0];
F = [0 0; 0 0; -1 0; 0 0; 0 0];
G = [1; 1; 2; 0; 0];

Et = [0; 0; 0; 0; 0];
Ft = [0 0; 0 0; 0 0; 0 1; 0 -1];
Gt = [0; 0; 0; 0.00000001; 0.00000001];