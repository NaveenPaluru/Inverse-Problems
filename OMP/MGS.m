function Q = MGS(V)

    % This codes implements Modified Gram Schmidt Algorithm
    % Ref : NLA by Trefethen and Bau

    % V is input matrix
    % Q is Othogonal Matrix


    [m, n] = size(V);
    
    Q = zeros(m,n);  % Othogonal Matrix
    
    % Dummy Variable
    x  = zeros(m,n); 
    
    for i = 1:n
        x(:,i) = V(:,i);
    end
     
    % loop to iterate over columns
    for i = 1:n
        Q(:,i) = x(:,i)./norm(x(:,i));
        % loop to remove the projections of remaining vectors along the formed orthogonal vector
        for j = i+1:n
            x(:,j) = x(:,j)-(Q(:,i)'*x(:,j))*Q(:,i);
        end
    end        
end