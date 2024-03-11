%% Plot results
close all;

% Time vector
t = 0:N_steps-1;

% Initialize arrays to store results
x_results = zeros(3, N_steps);
u_results = zeros(2, N_steps);

% Initialize state
exk = e0;
xrk = xr;

% Quadprog options
options = optimoptions('quadprog', 'Display', 'off');
warning('off', 'all');

for i = 1:N_steps
    A = [1 0 -vr*sin(xrk(3))*k; 0 1 vr*cos(xrk(3))*k; 0 0 1];
    B = [cos(xrk(3))*k 0; sin(xrk(3))*k 0; 0 k];

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

    % Contraints RHS vector
    bineq = G_tilde - F_tilde*A_tilde*exk;

    % State cost
    f = 2*exk.'*A_tilde.'*Q_tilde*B_tilde;

    % Get next optimal input and update SS
    eu_pred = quadprog(H,f,Aineq,bineq,[],[],[],[],[],options);
    if size(eu_pred, 1) == 0
        disp("Infeasible optimization problem at timestep " + i);
        break
    end
    euk = eu_pred(1:2);
    exk = A*exk + B*euk;

    % Store results
    x_results(:, i) = exk + [vr*cos(xrk(3)); vr*sin(xrk(3)); wr];
    u_results(:, i) = euk + ur;
end
warning('on', 'all');

figure;
subplot(2, 1, 1);
plot(t, x_results(1, :), 'b', 'LineWidth', 1.5);
hold on;
plot(t, x_results(2, :), 'r', 'LineWidth', 1.5);
hold on;
plot(t, x_results(3, :), 'g', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('State Value');
title('State Evolution');
legend('x_1', 'x_2', 'x_3');
grid on;

[ts1,us1] = stairs(t,u_results(1, :));
[ts2,us2] = stairs(t,u_results(2, :));
subplot(2, 1, 2);
plot(ts1, us1, 'k', 'LineWidth', 1.5);
hold on;
plot(ts2, us2, 'm', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('Control Input');
title('Control Input Evolution');
legend('u_1', 'u_2');
grid on;

%% Excercise 3.1:
clc;
clear;

% Time Step and Seconds
k = 0.1;
N_steps = 160;

% Define reference and initial condition
vr = 0.2;
wr = 1;
xr = [0; 0; 0];
ur = [vr; wr];
e0 = [0.1; 0; 0];

Np = 10;

Q = eye(3);
R = eye(2);

E = [1 0.23655; 1 -0.23655; -1 0.23655; -1 -0.23655];
F = [0 0 0; 0 0 0; 0 0 0; 0 0 0];
G = [0.46; 0.46; 0.46; 0.46];

Et = [0 0; 0 0; 0 0; 0 0];
Ft = [0 0 0; 0 0 0; 0 0 0; 0 0 0];
Gt = [0; 0; 0; 0];
