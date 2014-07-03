function [ x_rand ] = make_rand(p,s)

% create a random normalied vector for intializing 
% the SPCA coefficient, p = vector length
% s = number of non-zero components
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

x_rand = -1 + (1-(-1)).*rand(p,1);

if nargin == 2
    rand_vec = [ones(s, 1); zeros(p-s, 1)];
    rand_vec = rand_vec(randperm(p));
    x_rand = x_rand.*rand_vec;
end
    
x_rand = x_rand/norm(x_rand);


end

