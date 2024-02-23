
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
k = 1;

% Create LTI model object
plant = ss(A1, B1, C1, D1, k);

% Create MPC controller object
obj = mpc(plant, P, M);

% Define cost function weights
Q = eye(2); % State weight matrix
R = 1;      % Input weight

% Set cost function weights
obj.Weights.ManipulatedVariables = {R};
obj.Weights.OutputVariables = {Q};

% Initialize states
x_k = x0;

% Create MPCSTATE object
xc = mpcstate(obj);

for i = 1:20 % Run for 20 time steps
    % Obtain optimal control action
    [u_k, info] = mpcmove(obj, xc);
    
    % Apply first input to the system
    x_k = A1*x_k + B1*u_k;
    
    % Update the measured state
    xc.Plant = x_k;
    
    % Display results
    disp(['x_k:', num2str(x_k'), ', u_k:', num2str(u_k')]);
end