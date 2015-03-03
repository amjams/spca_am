% example on using "spca_am_multi.m"
% This example finds 3 leading sparse principal components of 
% a dataset with 5 variables and 13 observations
% using different sparsity for each component
%
% Refer to "spca_am.m" and "spca_am_multi.m" and [1] for details
% [1] Peter Richt???rik,  Martin Tak????, S. Damla Ahipasaoglu. Alternating
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
ns = 3;                        %number of desired components



%generate random intialization for each loading vector
x_rand_vec = zeros(p,ns);
for jj = 1:ns
    x_rand_vec(:,jj) = make_rand(p);
end
%Note: due to the random intialization, each run of this script will
%generate different coefficient vectors. Refer to
%"example_02_RandomInitializations.m" for details.


%parametrization of the problem

x1 = x_rand_vec;                    %loading vectors initial conditions
A = Astd;                           %data matrix

%the next 3 parameters determine which of the 8 formulations in [1] is
%computed
var_type = 2;                       %objctive function variance norm type
penalty = 0;                        %penalty or constraint (1 for penalty)
norm_type = 0;                      %norm type on penalty or constraint


gamma = [4 3 2];                    %gamma (or S) vector 
                                    %Note: gamma should be a vector of dimension
                                    %'ns' to specify the desired sparsity
                                    %for each components. Otherwise, the
                                    %first element of gamma will be
                                    %replicated for all coefficients 
maxIter = 200;                      %maximum number of iterations
STOP = 1+1e-6;                      %stopping criterion
deflationType = 1;                  %Deflation type (See deflate.m)


[all_coeff, EV, sparsity] = spca_am_multi(ns,x1, A, var_type, penalty, norm_type,gamma, maxIter, STOP, deflationType);





