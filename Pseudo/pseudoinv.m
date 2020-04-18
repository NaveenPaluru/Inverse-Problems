
%%

% This is a small demostration showing pseudo inverse  % Ref : https://en.wikipedia.org/wiki/Moore-Penrose_inverse

clc; clear all; close all;
rng(200);

% Case 1 : A is full rank. So A'A is invertible.

A = rand(15,5);
x = rand(5, 1);

% Forward  problem

y = A*x;

% Inverse problem : min_x ||Ax-y||2

xcap1 = inv(A'*A)*A'*y;
disp(['A is full rank']);
disp(['      x      Recon_x']);
disp([x xcap1]);

%-------------------------------------------------------------------------

% Case 2 : A is not full rank.

A(:,1) = A(:,2);

% Forward  problem

y = A*x;

% Inverse problem : min_x ||Ax-y||2 + lamda ||x||2

% Need to bring in regularization as A'A = (5 x 5) but its rank is rank(A)= rank(A'A) = 4

lambda=0.01;

xcap2 = inv(A'*A+lambda*eye(size(A,2)))*A'*y;


xcap1 = inv(A'*A)*A'*y;
disp(['A is not full rank']);
disp(['      x      Recon_x']);
disp([x xcap2]);

















