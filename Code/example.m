% An example of using a trained model to find the active and inactive
% electrodes in a given subject. The features describing each electrode and
% the GMM has been pre-computed here; we load the saved features and model
% for illustration. The example is for model trained with Induced Power
% high-gamma feature and gives sensitivity=100, specificity=86.7,
% aucroc=0.99.

%% load data
% pre-trained GMM model using IP-HG features from data of 115 subjects.
trained_gmm = load('../Data/trained_gmm_iphg.mat'); % pre-trained model for IP-HG feature

% pre-computed IP-HG feature for one subject with 114 electrodes. 
% Data struct contains two fields-
% ipfeat: 114x1 array of the IP-HG feature; one value for each electrode.
% ae_groundtruth: 114x1 0-1 array describing whether the electrode is
% active (=1) or inactive (=0) in the ground truth data. 
% Electrode index in ae_groundtruth are matched with the electrode index 
% of ipfeat.
subject_data = load('../Data/subject_data.mat'); 

%% apply the trained model to data from a subject

perf_res_mat = zeros(3,1); % sensitivity, specificity, AUCROC
aestruct = ActElecFromModel(subject_data.ipfeat, trained_gmm.gmm, ...
    subject_data.ae_groundtruth);
perf_res_mat(1) = aestruct.sensitivity;
perf_res_mat(2) = aestruct.specificity;
perf_res_mat(3) = aestruct.aucroc;
