% Define the matrix R
R = [
    1/sqrt(2), 0, 1/sqrt(2);
    -1/2, 1/sqrt(2), 1/2;
    -1/2, -1/sqrt(2), 1/2
];

% Display the matrix
disp('Matrix R:');
disp(R);

inverse = inv(R)
transpose = transpose(R)

