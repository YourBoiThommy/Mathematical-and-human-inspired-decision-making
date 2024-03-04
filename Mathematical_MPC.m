%% Plot results
% Time vector and simulation steps
t = 0:k:sec;
N_steps = length(t);

% Initialize arrays to store results
x_results = zeros(2, N_steps);
u_results = zeros(1, N_steps);

% Create MPCSTATE mpcobject
xc = mpcstate(mpcobj);

% Initialize state
x_k = x0;

for i = 1:N_steps
    % Obtain optimal control action
    [u_k, info] = mpcmove(mpcobj, xc);
    
    % Apply first input to the system
    x_k = mpcobj.Model.Plant.A*x_k + mpcobj.Model.Plant.B*u_k;
    
    % Update the measured state
    xc.Plant = x_k;
    
    % Store results
    x_results(:, i) = x_k;
    u_results(i) = u_k;

    % Display results
    % disp(['x_k:', num2str(x_k'), ', u_k:', num2str(u_k')]);
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

%% Exercise 1.1: Initialize
clear;

% Time Step and Seconds
k = 0.1;
sec = 120*k;

% Define system matrices
A1 = [1, 0.1; 0, 1];
B1 = [0; 0.1];
C1 = eye(2);
D1 = 0;

% Define initial condition
x0 = [10; 0];

% Define prediction horizon and control horizon
Np = 10;

% Create LTI model mpcobject
plant = ss(A1, B1, C1, D1, k);

% Create MPC controller mpcobject
mpcobj = mpc(plant);
mpcobj.PredictionHorizon = Np;

setEstimator(mpcobj,'custom');

% Define cost function weights
Q = eye(2); % State weight matrix
R = 1;      % Input weight

% Set cost function weights
mpcobj.Weights.ManipulatedVariables = {R};
mpcobj.Weights.OutputVariables = {Q};

%% Exercise 1.2: Change Q = 100I
Q = 10 * eye(2); % State weight matrix

% Set cost function weights
mpcobj.Weights.OutputVariables = {Q};

%% Exercise 1.3: Include input constraint |uk| < 1
% Set input constraints
mpcobj.MV(1).Min = -1;
mpcobj.MV(1).Max = 1;

%% Exercise 1.4: Include state constraint x_k[1] > -2
% Set state constraints
mpcobj.OV(1).Min = -2;

%% Exercise 1.5: Increase prediction horizon to Np = 100
% Define prediction horizon and control horizon
Np = 100;

% Create MPC controller mpcobject with updated prediction horizon
mpcobj.PredictionHorizon = Np;

%% Exercise 1.6: Include terminal constraint x_k+Np[2] = 0
% Define prediction horizon and control horizon
Np = 10;

% Create MPC controller mpcobject with updated prediction horizon
mpcobj.PredictionHorizon = Np;

% Define terminal constraint for the second element of the state vector
Y = struct('Min',[-Inf, 0],'Max',[Inf, 0]);
U = struct('Min',[-Inf,-Inf]);

% Include terminal constraint
setterminal(mpcobj, Y, U);

