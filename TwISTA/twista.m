


%
clc; clear all;close all;
rng(200);

%  This snippet shows the comparsion beween ISTA and twISTA.

%  TwISTA is Two-step IST (TwIST) algorithm that converges faster
%  than the simple IST even when A is severely ill-posed. Each of
%  iteration of the TwIST is performed based on the two previous
%  iterations.

% Forward Problem : Make sure x is sparse

x = zeros(1,100)';
x(7) = 1.3;x(27) = 1.3;x(32) = 1.7;x(68) = 2;x(88) = 1.2;
h = [1 2 3 4 3 2 1]/16;
y = conv(x,h);
y = y+0.05*randn(size(y));
N = 100;
H = convmtx(h',N);


lambda = 0.01; alpha = 1; beta = 1.5; %( >1 over relaxed version of ISTA)

xinit0 = H'*y;
xinit1 = xinit0;
iter = 250;

% Inverse Problem : Note that indesx 0 is for ISTA, index 1  for TwISTA

for i = 1:iter    
    
    xtemp0 = xinit0 - alpha * H'*(H*xinit0-y);
    xtemp1 = xinit1 - alpha * H'*(H*xinit1-y);
    xk0 = xtemp0;
    xk1 = xtemp1;
    % soft Threshold
    xtemp0 = sign(xk0).*(max(abs(xk0)-lambda*alpha,0));
    xinit0 = xtemp0;
    xtemp1 = sign(xk1).*(max(abs(xk1)-lambda*alpha,0));
   
    if i==1
        xinit1 = xtemp1;
    else
        xinit1 = (1-beta)*xinit1 + beta * xtemp1;
    end
    nse(i)= norm(H*xinit1-y);
    mse(i)= norm(H*xinit0-y);
    
end

figure;
plot(1:iter,mse,'r','LineWidth',3);hold on;
plot(1:iter,nse,'g','LineWidth',3);hold on;

ax = gca;ax.FontSize = 10; 
xlabel('Iter','FontSize',15);ylabel('mse','FontSize',15);
grid on;
legend('ISTA','TwISTA');

