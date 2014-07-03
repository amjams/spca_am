function [ U ] = U_gamma(v,gamma)

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

p = numel(v); 
U = zeros(p,1);

for i=1:p
U(i) = v(i)*max([0,(sign(v(i)^2 - gamma))]);

end
end

