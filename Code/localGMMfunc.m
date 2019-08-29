%% localGMMFunc
% computes GMM clusters for the data (active electrode metric/feature),
% assigns the small cluster as the active electrode cluster.
%
% INPUTS:
% num_clus: number of clusters in GMM. Provide 2 (one active cluster, one
% inactive cluster)
% datamatrix: NxD matrix on which clustering is done. N is the number of
% electrodes and D is the number of features describing each electrode.
% 
% OUTPUTS:
% a structure with the following fields:
% gmm: fitted Gaussian Mixture model
% aearray: Nx1 0-1 array of assigned clusters. Active is 1 and inactive is
% 0.
%

function [outstruct] = localGMMfunc(num_clus, datamatrix)
gmmoptions.MaxIter = 250;
gmmodel = fitgmdist(datamatrix, num_clus, 'Options',gmmoptions);
postprob = posterior(gmmodel, datamatrix);

[~, maxind] = max(postprob, [], 2);
prediction = maxind;
% find the smaller component and make its indices 1
if(gmmodel.ComponentProportion(1) < 0.5)
    prediction(prediction == 2) = 0;
else
    prediction = prediction - 1;
end

% populate output struct
outstruct.gmm = gmmodel; % fitted model
outstruct.aearray = prediction; % whether an electrode is active or inactive

end