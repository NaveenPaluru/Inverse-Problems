
%%

% This is a small demostration showing truncated SVD. For ill-conditioned matrices, 
% many of the eigenvalues, while not zero, can become quite small causing the data
% inversion to blow up if there is any noise at all present (and thereis always is 
% noise present). To prevent this, only the first n are included.

% Ref : https://www.nmr.mgh.harvard.edu/PMI/toolbox/Documentation/tsvd.xhtml


clc; clear all; close all;
rng(200);



A = rand(15,15); A(:,1) = A(:,2);
%  A is not full rank. So A'A is not invertible.

x = rand(15, 1);

% Forward  problem

y = A*x;

% inverse problem 

[U S V] = svd(A);

cutoff_percent = 10;

cutoff_val = S(1, 1) * cutoff_percent/100;

N = size(A,1); 

S_i = zeros(N, N);

for n = 1 : N
	if S(n, n) > cutoff_val
		S_i(n, n) = 1/S(n, n);
    end
end
	
xcap  = V' * S_i * U' * y;

xcap1 = V' * inv(S) * U' * y;

disp(['A is not full rank']);disp(['      x      x_tsvd     x_svd      ' ]);
disp([x  xcap  xcap1]);

