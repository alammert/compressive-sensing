function s_hat = zhangpassivegamma(Phi,y,h)
%
% Name: zhangpassivegamma
%
% Inputs:
%    Phi - m-by-n compressive sensing matrix
%    y - m-by-1 vector of subject responses (-1:no;+1:yes)
%    h - scalar value representing the degree of sparsity
% Outputs:
%    s_hat - n-by-1 sparse vector estimate of cognitive representation      
%
% Created by: Adam C. Lammert (2021)
%
% Description: Implementation of the analytical solution to one-bit 
%               compressive sensing described by Zhang et al. (2014).
%
% Reference: Zhang, L., Yi, J., & Jin, R. (2014, June). Efficient 
%               algorithms for robust one-bit compressive sensing. In 
%               International Conference on Machine Learning (pp. 820-828). 
% 

m = size(Phi,1);
n = size(Phi,2);

% obtain candidate basis coefficients
a = (1/m)*(Phi'*y);
val = sort(abs(a),'descend');
gamma = val(h+1);

% soft threshold the basis coefficients (perhaps)
if norm(a,inf) <= gamma
    s_hat = zeros(n,1);
else
    s_hat = (1/norm(P(a,gamma),2))*P(a,gamma);
end

return
%eof