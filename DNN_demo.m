% 2-layer deep learning model for SFDI
% need Matlab 2018b or above to run

clear;clc;
load('random_test_data_100x100.mat'); % load random test data
load('weights_2_layer_deep_learning_SFDI_model.mat'); % load parameters of DNN model

%% Estimate optical properties from random test data
X = Rd_vec;

% Layer 1
n1 = b1 + W1*X; % linear operation
a1 = n1 ./ (1 + abs(n1)); % nonlinear activation
% Layer 2
n2 = b2 + W2*a1; % linear operation
a2 = n2 ./ (1 + abs(n2)); % nonlinear activation
% output optical properties (OPs)
OPs = b3 + W3*a2; % linear operation

%% compare DNN-estimated OPs with known ground truth, and display mean and standard deviation of percent errors
Estimated_Mua = OPs(1,:);
Estimated_Musp = OPs(2,:);
perc_error_Mua = ((reshape(Estimated_Mua,[],1)-reshape(mat_True_Mua,[],1)) ./ reshape(mat_True_Mua,[],1)) * 100;
perc_error_Musp = ((reshape(Estimated_Musp,[],1)-reshape(mat_True_Musp,[],1)) ./ reshape(mat_True_Musp,[],1)) * 100;
% mean & std percent error for Mua
ave_Mua = mean(perc_error_Mua);
std_Mua = std(perc_error_Mua);
% mean & std percent error for Musp
ave_Musp = mean(perc_error_Musp);
std_Musp = std(perc_error_Musp);
disp(['Mua percent error, average: ', num2str(ave_Mua), '%; std: ', num2str(std_Mua), '%'])
disp(['Musp percent error, average: ', num2str(ave_Musp), '%; std: ', num2str(std_Musp), '%'])

