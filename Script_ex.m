%
% Name: Script_ex
%
% Created by: Adam C. Lammert (2022)
%
% Description: Script implementing a worked example of compressive sensing
% and its efficiency advantages for reconstructing reverse correlation 
% data. Four sub-examples are conducted, representing all combinations of
% two sample sizes (i.e., number of stimulus-response trials obtained from 
% a reverse correlation experiment) and two estimation methods (i.e., 
% conventional "reverse correlation" estimation and compressive sensing 
% estimation; see reverse_correlation.m and compressive_sensing.m). For 
% purposes of illustration, the underlying cognitive representation is 
% assumed, and the subject responses are simulated 
% (see subject_responses.m). See Fig 3 from the manuscript "Compressive
% Sensing for Cognitive Representations".
%

figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load the Assumed Cognitive Representation

C = load('cog_rep_letter_s.mat');
B = C.B; % <--- cognitive representation
clear C

% Determine representation dimensions
n1 = size(B,1);
n2 = size(B,2);
n = n1*n2;

% Vectorize cognitive representation
B = B(:);

% Visualize cognitive representation
subplot(1,6,1), imagesc(reshape(B,n1,n2)), xlabel(['"Cognitive"' 10 'Representation']), axis image, set(gca,'xtick',[],'ytick',[])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example #1: Reverse Correlation, Large Sample Size

m = 10000; % number of stimuli

% Create random matrix of stimuli
X = 2*(round(rand(m,n))-0.5);

% Simulate subject responses to stimuli
y = subject_responses(B,X);

% Estimate representation using reverse correlation
B_hat = reverse_correlation(y,X,n);

% Visualize estimated cognitive representation
subplot(1,6,2), imagesc(reshape(B_hat,n1,n2)), xlabel(['Conventional' 10 'Estim (n=10k)']), axis image, set(gca,'xtick',[],'ytick',[])

% Quantify estimation quality via correlation
r = corrcoef(B,B_hat);
fprintf('Squared Correlation - Conventional Estim (n=10k): %5.4f\n',r(1,2)^2)

% Visualize example unwhitened stimulus
subplot(1,6,6), imagesc(reshape(X(1,:),n1,n2)), xlabel('Noise Stimulus'), axis image, set(gca,'xtick',[],'ytick',[])

% End example
clear X y B_hat r l

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example #2: Reverse Correlation, Small Sample Size

m = 1000; % number of stimuli

% Create random matrix of stimuli
X = 2*(round(rand(m,n))-0.5);

% Simulate subject responses to stimuli
y = subject_responses(B,X);

% Estimate representation using reverse correlation
B_hat = reverse_correlation(y,X,n); 

% Visualize estimated cognitive representation
subplot(1,6,3), imagesc(reshape(B_hat,n1,n2)), xlabel(['Conventional' 10 'Estim (n=1k)']), axis image, set(gca,'xtick',[],'ytick',[])

% Quantify estimation quality via correlation
r = corrcoef(B,B_hat);
fprintf('Squared Correlation - Conventional Estim (n=1k): %5.4f\n',r(1,2)^2)

% End example
clear X y B_hat r l

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example #3: Compressive Sensing, Small Sample Size

m = 1000; % number of stimuli
gamma = 64; % degree of sparsity

% Create random matrix of stimuli
X = 2*(round(rand(m,n))-0.5);

% Simulate subject responses to stimuli
y = subject_responses(B,X);

% Estimate representation using compressive sensing
B_hat = compressive_sensing(y,X,n1,n2,gamma);

% Visualize estimated cognitive representation
subplot(1,6,4), imagesc(reshape(B_hat,n1,n2)), xlabel(['Compr Sens' 10 'Estim (n=1k)']), axis image, set(gca,'xtick',[],'ytick',[])

% Quantify estimation quality via correlation
r = corrcoef(B,B_hat);
fprintf('Squared Correlation - Compr Sens Estim (n=1k): %5.4f\n',r(1,2)^2)

% End example
clear X y B_hat r l gamma

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example #4: Compressive Sensing, Large Sample Size

m = 10000; % number of stimuli
gamma = 64; % degree of sparsity

% Create random matrix of stimuli
X = 2*(round(rand(m,n))-0.5);

% Simulate subject responses to stimuli
y = subject_responses(B,X);

% Estimate representation using compressive sensing
B_hat = compressive_sensing(y,X,n1,n2,gamma);

% Visualize estimated cognitive representation
subplot(1,6,5), imagesc(reshape(B_hat,n1,n2)), xlabel(['Compr Sens' 10 'Estim (n=10k)']), axis image, set(gca,'xtick',[],'ytick',[])

% Quantify estimation quality via correlation
r = corrcoef(B,B_hat);
fprintf('Squared Correlation - Compr Sens Estim (n=10k): %5.4f\n',r(1,2)^2)

% End example
clear X y B_hat r l

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

colormap gray

return
%eof