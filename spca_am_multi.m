
function [all_pc, EV, sparsity] = spca_am_multi(ns, x1, A, var_type, penalty, norm_type,gamma, maxIter, STOP, deflationType);

% Perfroms 8 formulations of the SPCA algorithm of Richt?rik et. al [1] and
% finds multiple sparse principal component coefficients
% [all_pc EV] = spca_am_multi(ns, x1, A, var_type, penalty, norm_type,gamma, maxIter, STOP, deflationType)
% inputs:
% ns             number of sparse components coefficients to be computed
% x0             the intial condition for the loadings vectors 
% A              the data matrix
% var_type       the norm of the variance of the objective function (1 or 2)
% penalty        1 if penalty, 0 if contraint
% norm_type      type of norm for the constraint or penalty (1 or 0)
% gamma         if penalty, S if contraint  (Readme.txt file for details)
% maxIter        maximum number of iteration
% STOP           stopping criteria
% defaltionType  Type of deflation used (See deflate.m) [default value=1]
% outputs:
% all_pc         all loadings vectors
% EV             the adjusted explained variance for each component
% sparsity       number of non-zero coefficients of the resulting vectors
%
% References:
% [1] Peter Richt?rik,  Martin Tak??, S. Damla Ahipasaoglu. Alternating
% Maximization: Unifying Framework for 8 Sparse PCA Formulations and
% Efficient Parallel Codes
% https://code.google.com/p/24am/
%
% See also: spca_am.m
%
%
% Code developed by: Ahmad Alsahaf (ahmadalsahaf@gmail.com)
% MSc student at Politecnico di Milano
% July, 2014

if nargin < 10
    deflationType = 1;
end
    

p = size(x1,1);                  %number of variables
n = size(A,1);                   %number of observations

% intitializations
all_pc = zeros(p,ns);            %desired coefficients
Ac = A;                          %current data matrix (deflated at each step)
sparsity = zeros(1,ns);           %sparsity vector

% replicate gammas
if length(gamma) ~= ns
  gamma = gamma(1)*ones(1,ns);
end

% replicate initial condition x1
mm = size(x1,2);
if mm ~= ns
  for ii = 1:ns
      x1(:,ii) = x1(:,1);
  end
end


%loop over the number of desired components
for i = 1:ns    
    [current_pc, nn, sparsity_now] =  spca_am(x1(:,i), Ac, var_type, penalty, norm_type,gamma(i), maxIter, STOP);
    all_pc(:,i) = current_pc;                        %add the current coeff vector
    sparsity(i) = sparsity_now;
    
    Ac_cov = cov(Ac);
    Ac_cov_ = deflate(Ac_cov,current_pc,deflationType);            %deflate current cov with the current coeff vector
    [Vg Dg] = eig(Ac_cov);                           %get the data matrix of the delated cov matrix
    Ac = Vg*sqrt(abs(Dg))*Vg';
    disp(strcat('SPCA #',num2str(i,'%02d')))
 
end


%calculate adjusted variance
[U1, S1, V1] = svd(A, 'econ');
D = diag(S1).^2/n;                  % standard PCA variances

if ns == 1
  SD = sum((A*all_pc).^2)/n;
else
  SD = diag(qr(A*all_pc,0)).^2/n;
end

EV = SD/sum(D);                     %adjusted variance 


end
    