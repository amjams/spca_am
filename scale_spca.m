function [ v_scaled ] = scale_spca( v )
% Scale the vector between 1 and -1 for SPCA
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

pp = length(v);
minv = min(v);
maxv = max(v);

for jj = 1:pp 
    v(jj) = (v(jj)-minv)/(maxv-minv);
    v(jj) = -1+(1-(-1))*v(jj);
end
v_scaled = v;

end

