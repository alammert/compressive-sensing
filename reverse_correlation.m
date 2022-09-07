function B_hat = reverse_correlation(y,X,n)
%
% Name: reverse_correlation
%
% Inputs:
%    y - m-by-1 vector of subject responses (-1:no;+1:yes)
%    X - m-by-n matrix of stimuli (rows:stimuli;columns:features)
%    n - scalar value representing the dimensionality of the stimuli
% Outputs:
%    B_hat - n-by-1 vector, estimate of cognitive representation      
%
% Created by: Adam C. Lammert (2022)
%
% Description: Reconstruct estimate of latent cognitive representation
%              using Reverse Correlation.
% 

% Reverse Correlation
B_hat = (1/n)*X'*y;

return
%eof