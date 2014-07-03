%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Description:

This is a Sparse Principal Component Analysis (SPCA) Toolbox which Perfroms 8 formulations of the SPCA algorithm of Richtárik et. al [1]
Refer to [1] before using this Toolbox

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Content:
case_obj_fun.m
deflate.m
make_rand.m
opt_lambda_s.m
scale_spca.m
spca_am.m
spca_am_multi.m
T_s.m
U_gamma.m
V_gamma.m
example_01_MultipleComponents.m
example_02_RandomInitializations.m
This README.txt file


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spca_am_multi.m

The main function that performs the algorithm for a single or multi sparse components

Function description:
% [all_pc EV] = spca_am_multi(ns, x1, A, var_type, penalty, norm_type,gamma, maxIter, STOP)
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
% outputs:
% all_pc         all loadings vectors
% EV             the adjusted explained variance for each component
% sparsity       number of non-zero coefficients of the resulting vectors


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Guidlines:  (Refer to [1] for more details)
The following are guidelines for parametrizing the problem

1- The 8 SPCA formulation
To determine which of the 8 formulation of [1] is solved, vary the following
parameters according to this table:
Formulation	Description	                     var_type	penalty   norm_type
1	      2-Norm objective, 0-norm constrained	2	  0	    0
2	      1-Norm objective, 0-norm constrained	1	  0	    0
3	      2-Norm objective, 1-norm constrained	2	  0	    1
4	      1-Norm objective, 1-norm constrained	1	  0	    1
5	      2-Norm objective, 0-norm penalized	2	  1	    0
6	      1-Norm objective, 0-norm penalized	1	  1	    0
7	      2-Norm objective, 1-norm penalized	2	  1	    1
8	      1-Norm objective, 1-norm penalized	1	  1	    1



2- Choosing gamma

For the above formulations, these are the guidelines for choosing gamma, the sparsity
controlling parameter:

For the constrained formulations, gamma should be chosen between 0 and the number of variables
and expect sparsity to decrease with gamma.*
while for the penalized formulations,  gamma between 0 and 1 
and expect sparsity to increase with gamma.

*for cases 1 and 2, gamma is equal exactly to the number of desired non-zero coefficients


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Reference:
[1] Peter Richtárik,  Martin Taká?, S. Damla Ahipasaoglu. 
Alternating Maximization: Unifying Framework for 8 Sparse PCA Formulations and
Efficient Parallel Codes
https://code.google.com/p/24am/


Developed by:
Ahmad Alsahaf
MSc student at Politecnico di Milano
July, 2014
contact: ahmadalsahaf@gmail.com


   
