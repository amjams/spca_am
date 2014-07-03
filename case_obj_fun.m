function [F, case_number] = case_obj_fun(x,y,A,penalty,var_type,norm_type, gamma)

% determine which of the 8 forumulations from the criteria: penalty
% var type, and penalty/constraint norm
% then calculate the correspondin objective function F(x,y)
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


case_number = 0;   %init

if penalty == 0 && var_type == 2 && norm_type == 0
    case_number = 1;
end
if penalty == 0 && var_type == 2 && norm_type == 1
    case_number = 3;
end
if penalty == 0 && var_type == 1 && norm_type == 0
    case_number = 2;
end
if penalty == 0 && var_type == 1 && norm_type == 1
    case_number = 4;
end
if penalty == 1 && var_type == 2 && norm_type == 0
    case_number = 5;
end
if penalty == 1 && var_type == 2 && norm_type == 1
    case_number = 7;
end
if penalty == 1 && var_type == 1 && norm_type == 0
    case_number = 6;
end
if penalty == 1 && var_type == 1 && norm_type == 1
    case_number = 8;
end


switch case_number
    case 1
        F = y'*A*x;
    case 2
        F = y'*A*x;
    case 3
        F = y'*A*x;
    case 4
        F = y'*A*x;
    case 5
        F = (y'*A*x).^2 - gamma*numel(find(x));
    case 6
        F = (y'*A*x).^2 - gamma*numel(find(x));
    case 7
        F = (y'*A*x).^2 - gamma*norm(x,1);
    case 8
        F = (y'*A*x).^2 - gamma*norm(x,1);
end
end

