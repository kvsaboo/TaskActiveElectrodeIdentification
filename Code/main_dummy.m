% This scripts highlights the steps involved in finding active electrodes.
% Code has been commented out with appropriate comments added to modify the
% script depending on the requirements.

%% compute spectrograms of each trial
% use a suitable method to compute the spectrogram of each trial of each
% electrode in the dataset. Do the computation for all electrodes of all
% the subjects and store them appropriately for further processing.

%% computation of metrics
% compute metrics summarizing the spectrum of each electrode. Sample code
% for three metrics -- induced power, smoothness score, and gamma
% consistency are given below. It computes the metrics for a specified
% electrode. Loop over all the subjects and electrodes appropriately to
% compute the metrics for all the electrodes; save the data in a matrix ExD
% matrix where E is the number of electrodes and D is the number of
% features describing each electrode.
%
% 'spectrogram_mat' is a TxFxN matrix of spectrograms for the given
% electrode. N is the number of trials. 'freq' is the frequencies involved
% in computing the spectrogram. Please check function description for more
% details.

% sample code - performs computations for only one electrode
% ip = inducedPower(spectrogram_mat, freq); 
% ss = smoothnessScore(spectrogram_mat, freq);
% gc = gammaConsistency(spectrogram_mat, freq);

%% train the GMM cluster
% cluster the data from all electrodes together to find Gaussian Mixture
% Model describing the active and inactive electrodes. Output of the
% function contains the fitted mixture. data_matrix has size ExD.

% gmout = localGMMfunc(2, data_matrix);

%% apply the trained model to data from another subject

% compute the metrics used while clustering for data from a given subject and
% store them in a matrix of size EtxD where Et is the number of electrodes
% for the given subject and D is the number of features. 

% apply model to the data; provide ground truth active electrode 
% information if available.

% perf_res_mat = zeros(3,1); % store sensitivity, specificity, AUCROC
% aestruct = ActElecFromModel(data_matrix_given_subject, gmout.gmm, ...
%     ground_truth_given_subject);
% perf_res_mat(1) = aestruct.sensitivity;
% perf_res_mat(2) = aestruct.specificity;
% perf_res_mat(3) = aestruct.aucroc;

