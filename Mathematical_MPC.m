
% Define system matrices
A1 = [1, 0.1; 0, 1];
B1 = [0; 0.1];
C1 = eye(2);
D1 = 0;

% Define prediction horizon and control horizon
P = 10;
M = 1;

% Define initial condition
x0 = [10; 0];

% Define number of states and inputs
n_states = size(A1, 1);
n_inputs = size(B1, 2);

% Time Step
k = 0.1;

% Create LTI model mpcobject
plant = ss(A1, B1, C1, D1, k);

% Create MPC controller mpcobject
mpcobj = mpc(plant, P, M);
setEstimator(mpcobj,'custom');

% Define cost function weights
Q = eye(2); % State weight matrix
R = 1;      % Input weight

% Set cost function weights
mpcobj.Weights.ManipulatedVariables = {R};
mpcobj.Weights.OutputVariables = {Q};

% Initialize states
x_k = x0;

% Create MPCSTATE mpcobject
xc = mpcstate(mpcobj);

for i = 1:20 % Run for 20 time steps
    % Obtain optimal control action
    [u_k, info] = mpcmove(mpcobj, xc);
    
    % Apply first input to the system
    x_k = A1*x_k + B1*u_k;
    
    % Update the measured state
    xc.Plant = x_k;
    
    % Display results
    disp(['x_k:', num2str(x_k'), ', u_k:', num2str(u_k')]);
end

%%
% Exercise 1.2: Change Q = 100I
Q = 100 * eye(2); % State weight matrix

% Set cost function weights
mpcobj.Weights.ManipulatedVariables = {R};
mpcobj.Weights.OutputVariables = {Q};

% Initialize states
x_k = x0;

% Create MPCSTATE mpcobject
xc = mpcstate(mpcobj);

for i = 1:20 % Run for 20 time steps
    % Obtain optimal control action
    [u_k, info] = mpcmove(mpcobj, xc);
    
    % Apply first input to the system
    x_k = A1*x_k + B1*u_k;
    
    % Update the measured state
    xc.Plant = x_k;
    
    % Display results
    disp(['x_k:', num2str(x_k'), ', u_k:', num2str(u_k')]);
end

%%
% Exercise 1.3: Include input constraint |uk| < 1
% Set input constraints
mpcobj.MV(1).Min = -1;
mpcobj.MV(1).Max = 1;

% Initialize states
x_k = x0;

% Create MPCSTATE mpcobject
xc = mpcstate(mpcobj);

for i = 1:20 % Run for 20 time steps
    % Obtain optimal control action
    [u_k, info] = mpcmove(mpcobj, xc);
    
    % Apply first input to the system
    x_k = A1*x_k + B1*u_k;
    
    % Update the measured state
    xc.Plant = x_k;
    
    % Display results
    disp(['x_k:', num2str(x_k'), ', u_k:', num2str(u_k')]);
end

%%

% Exercise 1.4: Include state constraint x_k[1] > -2
% Set state constraints
mpcobj.OV(1).Min = -2;

% Initialize states
x_k = x0;

% Create MPCSTATE mpcobject
xc = mpcstate(mpcobj);

for i = 1:20 % Run for 20 time steps
    % Obtain optimal control action
    [u_k, info] = mpcmove(mpcobj, xc);
    
    % Apply first input to the system
    x_k = A1*x_k + B1*u_k;
    
    % Update the measured state
    xc.Plant = x_k;
    
    % Display results
    disp(['x_k:', num2str(x_k'), ', u_k:', num2str(u_k')]);
end

%%

% Exercise 1.5: Increase prediction horizon to Np = 100
% Define prediction horizon and control horizon
Np = 100;
M = 1;

% Create MPC controller mpcobject with updated prediction horizon
mpcobj = mpc(plant, Np, M);

% Set cost function weights
mpcobj.Weights.ManipulatedVariables = {R};
mpcobj.Weights.OutputVariables = {Q};

% Set input constraints
mpcobj.MV(1).Min = -1;
mpcobj.MV(1).Max = 1;

% Set state constraint
mpcobj.OV(1).Min = -2;

% Initialize states
x_k = x0;

% Create MPCSTATE mpcobject
xc = mpcstate(mpcobj);

for i = 1:20 % Run for 20 time steps
    % Obtain optimal control action
    [u_k, info] = mpcmove(mpcobj, xc);
    
    % Apply first input to the system
    x_k = A1*x_k + B1*u_k;
    
    % Update the measured state
    xc.Plant = x_k;
    
    % Display results
    disp(['x_k:', num2str(x_k'), ', u_k:', num2str(u_k')]);
end

%%
% Exercise 1.6: Include terminal constraint x_k+Np[2] = 0
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
%TerminalConstr.A = zeros(size(A1, 1), size(A1, 1) * P);
%TerminalConstr.A(2, end-1:end) = [1 -1]; % Second element difference
%TerminalConstr.B = 0;

% Include terminal constraint
%mpcobj = setterminal(mpcobj, TerminalConstr);
% Initialize states
x_k = x0;

% Create MPCSTATE mpcobject
xc = mpcstate(mpcobj);

for i = 1:20 % Run for 20 time steps
    % Obtain optimal control action
    [u_k, info] = mpcmove(mpcobj, xc);
    
    % Apply first input to the system
    x_k = A1*x_k + B1*u_k;
    
    % Update the measured state
    xc.Plant = x_k;
    
    % Display results
    disp(['x_k:', num2str(x_k'), ', u_k:', num2str(u_k')]);
end

