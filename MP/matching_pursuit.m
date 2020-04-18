%% Matching Pursuit Algorithm for solving Ax = y

%Ref: https://link.springer.com/book/10.1007%2F978-981-13-3597-6
%Ref: Mallat, S., Zhang, Z.: Matching pursuits with time-frequency
%dictionaries. IEEE Trans. Signal  Process. 41, 3397–3415 (1993)

% Naveen Paluru ; April 16, 2020

% MP is a simple algorithm, that can solve for x which is sparse
% in its domain, assuming given an underdetermined orthogonal sen
% -sing matrix. For simplicity we assumed that sensing matrix is of
% full rank. This is a simple program that shows MP can solve forx.
% In reality, there is no gaurantee that, MP converges.

% Make the forward problem

rng(200);

A = [1 4 7 9;
     6 9 2 7;
     5 9 2 1
     6 7 4 3];
A = MGS(A);
x = (rand(4,1));
y = A*x;

% Inverse problem

xcap = zeros(4,1);
epsi = 1e-10;iter = 1;

while(true)
    r = y-A*xcap;
    nmr(iter)=norm(r);
    pr= A'*r;
    idx = find(pr==max(pr(:)));
    xcap(idx) = xcap(idx)+(A(:,idx)'*r);   
    if norm(r)<epsi
        break;
    end
    iter=iter+1;
end

plot(1:iter,nmr,'r','LineWidth',3);
ax = gca;ax.FontSize = 10; 
xlabel('Iter','FontSize',15);ylabel('Residue','FontSize',15);
grid on;

