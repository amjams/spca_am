function [ At ] = deflate(A,x,type)
%  Covariance matrix deflation
%  A is a covariance matrix
%  x is the leading eigen vector of the matrix
%  At is the resulting covariance matrix after deflation with x
%  type: takes values 1,2, or 3  is the delfation type
%  1: Hoteling deflation
%  2: Projection deflation
%  3: Schure dedlation
%  Default: 1 Hoteling 
%
% Refer to 'spca_am', and [2] for details
% [1] Peter Richt???rik,  Martin Tak????, S. Damla Ahipasaoglu. Alternating
% Maximization: Unifying Framework for 8 Sparse PCA Formulations and
% Efficient Parallel Codes
% https://code.google.com/p/24am/
%
% [2] Mackey, Lester W. "Deflation methods for sparse PCA." Advances in 
% neural information processing systems. 2009.
%
% [3] http://wikicoursenote.com/wiki/Deflation_Methods_for_Sparse_PCA 
%
% Code developed by: Ahmad Alsahaf (ahmadalsahaf@gmail.com)
% MSc student at Politecnico di Milano
% July, 2014


if nargin < 3
    type = 1;
end

n = size(A,1);

if type ==1                      
    At = A - x*x'*A*x*x';                        % Hotelings
else if type ==2
        At = (eye(n)-x*x')*A*(eye(n)-x*x');      % Projection deflation
    else if type ==3
            At = A - (A*x*x'*A)/(x'*A*x);        % Schur deflation
        end
    end
end

