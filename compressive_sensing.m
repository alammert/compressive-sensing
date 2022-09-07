function B_hat = compressive_sensing(y,X,n1,n2,gamma)
%
% Name: compressive_sensing
%
% Inputs:
%    y - m-by-1 vector of subject responses (-1:no;+1:yes)
%    X - m-by-n matrix of stimuli (rows:stimuli;columns:features)
%    n1 - scalar value representing the vertical dimensionality 
%           of the (2D image) stimuli
%    n2 - scalar value representing the horizontal dimensionality 
%           of the (2D image) stimuli
%    gamma - scalar value representing the degree of sparsity
% Outputs:
%    B_hat - n-by-1 vector, estimate of cognitive representation      
%
% Created by: Adam C. Lammert (2022)
%
% Description: Reconstruct estimate of latent cognitive representation
%              using Compressive Sensing.
% 

m = size(X,1);
n = n1*n2;

% Calculate the Compressive Sensing Matrix, Theta
Theta = zeros(m,n);
for ii = 1:n
    ek = zeros(n1,n2);
    ek(ii) = 1;
    psi = idct2(ek);
    Theta(:,ii) = X*psi(:);
end

% Obtain Sparse Vector of Basis Coefficients using Zhang's (2014) Method
s = zhangpassivegamma(Theta,y,gamma);

% Reconstruct the Cognitive Representation from the Sparse Vector 
% and the Basis Functions ("decompress")
B_hat = zeros(n,1);
for ii = 1:n
    ek = zeros(n1,n2);
    ek(ii) = 1;
    psi = idct2(ek);
    B_hat = B_hat + psi(:)*s(ii);
end

return
%eof