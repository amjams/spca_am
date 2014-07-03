function [ At ] = deflate(A,x)
%  Covariance matrix deflation
%  A is a covariance matrix
%  x is the leading eigen vector of the matrix
%  At is thr resulting covariance matrix after deflation with x
%
% Refer to spca_am and [1] for details
% [1] Peter Richtárik,  Martin Taká?, S. Damla Ahipasaoglu. Alternating
% Maximization: Unifying Framework for 8 Sparse PCA Formulations and
% Efficient Parallel Codes
% https://code.google.com/p/24am/
%
%
% Code developed by: Ahmad Alsahaf (ahmadalsahaf@gmail.com)
% MSc student at Politecnico di Milano
% July, 2014

At = A - x*x'*A*x*x';


end

