%% Plot results
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
plot(1:N_steps, x_results(1, :), 'b', 'LineWidth', 1.5);
hold on;
plot(1:N_steps, x_results(2, :), 'r', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('State Value');
title('State Evolution');
legend('x_1', 'x_2');
grid on;

subplot(2, 1, 2);
plot(1:N_steps, u_results, 'k', 'LineWidth', 1.5);
xlabel('Time Step');
ylabel('Control Input');
title('Control Input Evolution');
grid on;

%% Exercise 1.1: Initialize
% Time Step
k = 1;
N_steps = 200;

% Define system matrices
A1 = [1, 0.1; 0, 1];
B1 = [0; 0.1];
C1 = eye(2);
D1 = 0;

% Define prediction horizon and control horizon
Np = 10;

% Define initial condition
x0 = [10; 0];

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
mpcobj.Weights.ManipulatedVariables = {R};
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
M = 1;

% Create MPC controller mpcobject with updated prediction horizon
mpcobj.PredictionHorizon = Np;

%% Exercise 1.6: Include terminal constraint x_k+Np[2] = 0
% Define prediction horizon and control horizon
P = 10;
M = 1;

% Create MPC controller mpcobject
mpcobj = mpc(plant, P, M);

% Set cost function weights
mpcobj.Weights.ManipulatedVariables =  {R};
mpcobj.Weights.OutputVariables      =  {Q};

% Set input constraints
mpcobj.MV(1).Min =    -1;
mpcobj.MV(1).Max =     1;

% Set state constraint x_k[1] > -2
mpcobj.OV(1).Min = -2;

% Define terminal constraint for the second element of the state vector
%TerminalConstr =  struct('Weight',[0,10], 'Min',[-inf, 0],'Max',[Inf, 0])
%U = struct('Min',[1,-Inf]);

% Include terminal constraint
%setterminal(mpcobj, TerminalConstr);
% Include terminal constraint
%setterminal = mpcobj

%% Excercise 1.7: 

% Define system matrices
A2 = [4/3, -2/3; 1, 0];
B2 = [1; 0];
C2 = eye(2);
D2 = 0;

% Define prediction horizon and control horizon
P2 = 5;
M2 = 1;

% Define initial condition
x0 = [10; 0];

% Time Step
k = 1;

% Create LTI model mpcobject
plant2 = ss(A2, B2, C2, D2, k);

% Create MPC controller mpcobject
mpcobj2 = mpc(plant2, P2, M2);
setEstimator(mpcobj2,'custom');

% Define cost function weights
Q2 = [sqrt(4/3+0.001), sqrt(-2/3); sqrt(-2/3), sqrt(1.001)]; % State weight matrix
R2 = 0.001;                                                  % Input weight

% Set cost function weights
mpcobj2.Weights.ManipulatedVariables = {R2};
mpcobj2.Weights.OutputVariables = {Q2};