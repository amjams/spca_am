function [PC_loading ,nIter ,sparsity, all_loadings] = spca_am(x1, A, var_type, penalty, norm_type,gamma, maxIter, STOP)

% Perfroms 8 formulations of the SPCA algorithm of Richtárik et. al [1]
% [PC_loading ,nIter, all_loadings] = spca_am(x1, A, var_type, penalty, norm_type,gamma, maxIter, STOP)
% inputs:
% x0             the intial condition for the loadings vector
% A              the data matrix
% var_type       the norm of the variance of the objective function (1 or 2)
% penalty        1 if penalty, 0 if contraint
% norm_type      type of norm for the constraint or penalty (1 or 0)
% gamma         if penalty, S if contraint  (Readme.txt file for details)
% maxIter        maximum number of iteration
% STOP           stopping criteria
% outputs:
% PC_loading     the loadings vector of the leading SPCA
% nIter          the number of iterations before convergence
% sparsity       number of non-zero coefficients of the resulting vector
% all_loading    the loadings vector at each iteration
%
% References:
% [1] Peter Richtárik,  Martin Taká?, S. Damla Ahipasaoglu. Alternating
% Maximization: Unifying Framework for 8 Sparse PCA Formulations and
% Efficient Parallel Codes
% https://code.google.com/p/24am/
%
%
% Code developed by: Ahmad Alsahaf (ahmadalsahaf@gmail.com)
% MSc student at Politecnico di Milano
% July, 2014


if nargin > 8
    error('Too many inputs')
end

if nargin < 8
    STOP = -1e6;
end

if nargin < 7
    maxIter = 200;
end

if nargin < 6
    error('Not enough inputs')
end


p = size(x1,1);               %number of variables
n = size(A,1);                %number of observations

%intitalize x and y vectors and F
x = zeros(p,maxIter+1);  x(:,1) = x1;
y = zeros(n,maxIter);
F = zeros(1,maxIter+1);  F(1) = 0.1;


if penalty == 0      
    s = gamma;
end

%initialize iteration variables and start the loop
k = 1;    kill = 1e6;                        
while k<= maxIter && kill >STOP         

u = A*x(:,k);
if var_type == 1
    y(:,k) = sign(u);
else
    y(:,k) = u/norm(u);
end

v = A'*y(:,k);                      %update v

% scale v to [-1,1] for all but formulation 1
if norm_type ==  1 || penalty == 1
     v = scale_spca(v);
end



% if penalty
if penalty == 1          
    if norm_type == 0    
        x(:,k+1) = U_gamma(v,gamma)/norm(U_gamma(v,gamma));
    else                 
        x(:,k+1) = V_gamma(v,gamma)/norm(V_gamma(v,gamma));
    end
end

% if constraint 
if penalty == 0
    if norm_type == 0   
        x(:,k+1) = T_s(v,s)/norm(T_s(v,s));
    else                
        lambda_opt = fminbnd(@(lambda_s) opt_lambda_s(lambda_s,s,v),0,100000);
        x(:,k+1) = V_gamma(v,lambda_opt)/norm(V_gamma(v,lambda_opt));
    end
end

F(k+1) = case_obj_fun(x(:,k+1),y(:,k),A,penalty,var_type,norm_type, gamma);

if k == 1                     %bypass the stopping criterion for the first iteration
    kill = 10;
else
    kill = F(k+1)/F(k);       %update stopping criterion
end
k = k+1;                      %update iteration number
end


PC_loading = x(:,k-1);
nIter = k-1;
all_loadings = x;
sparsity = numel(find(PC_loading));



