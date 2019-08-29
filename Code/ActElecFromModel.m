%% ActElecFromModel
% assigns electrode as active/inactive based on trained GMM model. Computes
% sensitivity, specificity, and AUC-ROC of prediction if ground truth is
% available.
%
% INPUTS:
% datamatrix: NxD matrix of electrode data. N is the number of
% electrodes and D is the number of features describing each electrode.
% gmmodel: trained GMM model. Number of dimensions for the Gaussian
% distribution is D following the same feature ordering as the datamatrix.
% ground_truth: Nx1 array where N is the number of electrodes. 
% ground truth active/inactive information for each electrode; 1 is active
% and 0 is inactive.
%
% OUTPUTS:
% a structure with the following fields:
% aearray: Nx1 0-1 array of assigned clusters. Active is 1 and inactive is
% 0.
% sensitivity, specificity, AUC-ROC: metrics to evaluate prediction
% performance
%

function [outstruct] = ActElecFromModel(datamatrix, gmmodel, ground_truth)

%% assign electrode as active/inactive based on input GMM model
% posterior probability of belonging to a cluster based on the input GMM
% model
postprob = posterior(gmmodel, datamatrix); 

% Look at the higher posterior and assign active electrode

[~, maxind] = max(postprob, [], 2);
prediction = maxind; % active/inactive value for each electrode
% find the smaller component and make its indices 1; index 1 corresponds to
% active electrode
if(gmmodel.ComponentProportion(1) < 0.5)
    prediction(prediction == 2) = 0;
else
    prediction = prediction - 1;
end

%% compute sensitivity, specificity, and AUC-ROC of prediction if ground_truth is available

if ~isempty(ground_truth)
    % if there is only one class in ground_truth and prediction
    if (length(unique(ground_truth)) == 1) && (length(unique(prediction)) == 1)
        
        % one prediction matches, all match and the sensitivity,
        % specificity is taken to be hundred
        if  (ground_truth(1) == prediction(1))
            sensitivity = 100;
            specificity = 100;
        
        % if no predictions match, then we take sensitivity, specificity to be zero
        else
            sensitivity = 0;
            specificity = 0;
        end
        
        % if there is only one class in ground truth, then AUCROC is not valid
        AUCROC = nan;
    
    elseif length(unique(ground_truth)) == 1
        % find sensitivity and specificity
        conf = confusionmat(ground_truth, prediction);
        sensitivity = 100*conf(2,2)/sum(conf(2,:));
        specificity = 100*conf(1,1)/sum(conf(1,:));
        
        AUCROC = nan;  
    else
        % find sensitivity and specificity
        conf = confusionmat(ground_truth, prediction);
        sensitivity = 100*conf(2,2)/sum(conf(2,:));
        specificity = 100*conf(1,1)/sum(conf(1,:));

        % compute AUC-ROC
        if(gmmodel.ComponentProportion(1) < 0.5) % pick posterior prob based on the smaller component
            [~,~,~,AUCROC] = perfcurve(ground_truth, postprob(:,1), 1);
        else
            [~,~,~,AUCROC] = perfcurve(ground_truth, postprob(:,2), 1);
        end
    end
else 
    % if ground truth is not available, then sensitivity, specificity, and
    % AUCROC cannot be computed.
    sensitivity = -1;
    specificity = -1;
    AUCROC = -1; 
end

%% populate output struct

outstruct.aearray = prediction; % whether an electrode is active or inactive
outstruct.sensitivity = sensitivity;
outstruct.specificity = specificity;
outstruct.aucroc = AUCROC;

end