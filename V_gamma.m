function [ V ] = V_gamma(v,gamma)

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

V = zeros(p,1);

for i=1:p
V(i) = sign(v(i))*  max([0,(abs(v(i)) - gamma)]);

end
end
