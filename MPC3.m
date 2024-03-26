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
xk = xr;
uk = ur;

% Quadprog options
options = optimoptions('quadprog', 'Display', 'off');
warning('off', 'all');
for i = 1:N_steps


    % Store results
    x_results(:, i) = xk;
    r_results(:, i) = xrk;
    u_results(:, i) = uk;

    A = [1 0 -vr*sin(xrk(3))*k; 0 1 vr*cos(xrk(3))*k; 0 0 1];
    B = [cos(xrk(3))*k 0; sin(xrk(3))*k 0; 0 k];

    B_tilde = [];
    for a = 1:Np
        Bi = [];
        for b = 1:Np
            if a-b < 0
                Bij = zeros(size(B));
            else
                Bij = A^(a-b) * B;
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
    for j = 1:Np
        if j == Np
            E_tilde = blkdiag(E_tilde, E + Et);
            F_tilde = blkdiag(F_tilde, F + Ft);
            G_tilde = [G_tilde; G + Gt];
        else
            E_tilde = blkdiag(E_tilde, E);
            F_tilde = blkdiag(F_tilde, F);
            G_tilde = [G_tilde; G];
        end
        A_tilde = [A_tilde; A^j];
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
    exk;
    euk = eu_pred(1:2);
    exk = A*exk + B*euk + W(:, i);

    %xk = exk + xrk;
    xk(1) = (ur(1)+euk(1))*cos(xrk(3)+exk(3))*k + xk(1);
    xk(2) = (ur(1)+euk(1))*sin(xrk(3)+exk(3))*k + xk(2);
    xk(3) = (ur(2)+euk(2))*k + xk(3);

    uk = euk + ur;

    % Update Reference
    theta_r = xrk(3)+ur(2)*k;
    xrk(3) = theta_r;
    
end
warning('on', 'all');


% Plot the trajectory in the x-y plane
h = figure;
plot(x_results(1, :), x_results(2, :), 'b', 'LineWidth', 1.5);
hold on
plot(r_results(1, :), r_results(2, :), 'r', 'LineWidth', 1.5);
%plot(xr(1), xr(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % Plot the reference point
xlabel('X Position');
ylabel('Y Position');
title('Robot Trajectory');
grid on;
legend('Robot Trajectory', 'Reference Trajectory');

p = figure;
subplot(4, 1, 1);
plot(t, x_results(1, :), 'b', 'LineWidth', 1.5);
ylabel('State Value');
title('State Evolution');
legend('x_1');
grid on;

subplot(4, 1, 2);
plot(t, x_results(2, :), 'r', 'LineWidth', 1.5);
ylabel('State Value');
legend('x_2');
grid on;

subplot(4, 1, 3);
plot(t, x_results(3, :), 'g', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('State Value');
legend('x_3');
grid on;

[ts1,us1] = stairs(t,u_results(1, :));
[ts2,us2] = stairs(t,u_results(2, :));
subplot(4, 1, 4);
plot(ts1, us1, 'k', 'LineWidth', 1.5);
hold on;
plot(ts2, us2, 'm', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('Control Input');
title('Control Input Evolution');
legend('u_1', 'u_2');
grid on;

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h, append(pwd,'\',name,'state+input','.pdf'),'-dpdf','-r0')

set(p,'Units','Inches');
pos = get(p,'Position');
set(p,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(p, append(pwd,'\',name,'traj','.pdf'),'-dpdf','-r0')

%% Excercise 3.1:
clc;
clear;

% Time Step and Seconds
k = 0.1;
N_steps = 500;

% Define reference and initial condition
vr = 0.2;
wr = 1;
xr = [ 0; 0; 0];
ur = [vr; wr];
e0 = [0.1; 0; 0];
xr = xr + e0;
Np  = 10;

Q = eye(3);
R = eye(2);

E = [1 0.23655; 1 -0.23655; -1 0.23655; -1 -0.23655];
F = [0 0 0; 0 0 0; 0 0 0; 0 0 0];
G = [0.46+vr+0.23655*wr; 0.46+vr-0.23655*wr; 0.46-vr+0.23655*wr; 0.46-vr-0.23655*wr];

Et = [0 0; 0 0; 0 0; 0 0];
Ft = [0 0 0; 0 0 0; 0 0 0; 0 0 0];
Gt = [0; 0; 0; 0];

W = zeros(3, N_steps);

name='3.1';

%% Excercise 3.2: 
W = normrnd(0,0.0001,3,N_steps);
e0 = [0; 0; 0];
xr = [ 0; 0; 0];
xr = xr + e0;

name='3.2';


%% Excercise 3.3:
Q = 1*eye(3);
R = 100*eye(2);

name='3.3';

%% Excercise 3.4:
W = normrnd(0,0.1,3,N_steps);
e0 = [0; 0; 0];
xr = [ 0; 0; 0];
xr = xr + e0;

name='3.4';
