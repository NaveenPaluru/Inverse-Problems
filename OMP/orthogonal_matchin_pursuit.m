%%  Orthogonal Matching Pursuit Algorithm for solving Ax = y

%Ref: https://link.springer.com/book/10.1007%2F978-981-13-3597-6
%Ref: Pati, Y.C., Rezaiifar, R., Rezaiifar, Y.C.P.R., Krishnaprasad, P.S.: Orthogonal matching 
% pursuit : recursive function approximation with applications to wavelet decomposition. In: 
% Proceedings %of the 27th Annual Asilomar Conference on Signals, Systems, and Computers, pp. 40–44
%(1993)

% Naveen Paluru ; April 17, 2020

% OMP is a simple algorithm, that can solve for x which is sparse
% in its domain, assuming given an underdetermined orthogonal sen
% -sing matrix. For simplicity we assumed that sensing matrix is of
% full rank. This is a simple program that shows OMP can solve forx.
% 

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
epsi = 1e-15;iter = 1;
indices = [];

while(true)
    r = y-A*xcap;
    nmr(iter)=norm(r);
    pr= A'*r;
    idx  =  find(pr==max(pr(:)));
    unq = unique(indices);
    if length(unq)~=4
        indices = cat(1,indices,idx);
    end
    xcap(indices) = A(:,indices)\y;
    if norm(r)<epsi
        break;
    end
    iter=iter+1;
end

plot(1:iter,nmr,'r','LineWidth',3);
ax = gca;ax.FontSize = 10; 
xlabel('Iter','FontSize',15);ylabel('Residue','FontSize',15);
grid on;

