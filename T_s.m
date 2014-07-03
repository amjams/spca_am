function [ T ] = T_s(v,s)

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

[v_abs_sorted idx] = sort(abs(v),'descend');
T = zeros(p,1);
idx = idx(1:s);

for i=1:p
    if ismember(i,idx)
        T(i) = v(i);
    end
end

end

