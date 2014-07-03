% to find optimal lambda from given s
% constraint to penalty variable
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


function f = opt_lambda_s(lambda_s,s,v)
f = (lambda_s)*sqrt(s)+ norm(V_lambda(v,lambda_s));
end
