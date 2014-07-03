% example on using "spca_am_multi.m"
% This example finds 1 leading sparse principal components of 
% a dataset with 5 variables and 13 observations with multiple random
% initializations, and chooses the resulting sparse component that
% maximizes explained variance
%
%
% Refer to "spca_am.m" and "spca_am_multi.m" and [1] for details
% [1] Peter Richtárik,  Martin Taká?, S. Damla Ahipasaoglu. Alternating
% Maximization: Unifying Framework for 8 Sparse PCA Formulations and
% Efficient Parallel Codes
% https://code.google.com/p/24am/
%
%
% Code developed by: Ahmad Alsahaf (ahmadalsahaf@gmail.com)
% MSc student at Politecnico di Milano
% July, 2014



clear all
clc

A = importdata('hald.mat');    %load the data set
A = A.hald;
%standardize the data
meanA = mean(A);
stdA = std(A);
stdA(stdA==0) = 1;
Astd = bsxfun(@minus,A, meanA);
Astd = bsxfun(@rdivide, Astd, stdA);


%dimensions
[n p] = size(A);               %n:observations, p:variables
ns = 1;                        %number of desired components
L = 50;                        %number of intializations
%Note: the number of initializations used here is for illustrative purposes
%and may not be sufficient for datasets of higher dimension. Refer to [1] for
%better guidelines.




%parametrization of the problem

A = Astd;                           %data matrix
%the next 3 parameters determine which of the 8 formulations in [1] is
%computed
var_type = 2;                       %objctive function variance norm type
penalty = 0;                        %penalty or constraint (1 for penalty)
norm_type = 0;                      %norm type on penalty or constraint
gamma = 3;                          %sparsity controlling parameter
maxIter = 200;                      %maximum number of iterations
STOP = 1+1e-6;                      %stopping criterion


%initializations
best_EV = 0;                        
all_coeff = zeros(p,L);

%starting the loop
for ix =1:L
x1 = make_rand(p);                  %random initialization

[coeff EV] = spca_am_multi(ns,x1, A, var_type, penalty, norm_type,gamma, maxIter, STOP);
all_coeff(:,ix) = coeff;

%savimg the best outcome (highest EV)
if EV > best_EV
    best_EV = EV;
    best_init = x1;
    best_coeff = coeff;
end
disp(strcat('Iteration #',num2str(ix,'%03d')))
end




