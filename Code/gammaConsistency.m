%% gammaConsistency
% calculates the gamma consistency metric i.e., the synchrony between the
% different sub-bands in gamma. See code to see how the sub-bands are
% found.
%
% INPUTS:
% spectrogram_mat: This stores the spectrogram for each trial of an
% electrode. Dimensionality- TxFxN where T is the number of time points, F
% is the number of frequencies and N is the number of trials. Each point in
% the matrix represents the spectral power for the given (time, frequency,
% trial).
% freq: array of frequencies for which the spectrogram has been created.
% Length must be F (to be compatible with the other inputs).
%
% OUTPUTS:
% gcscore - 3x1 matrix with the gamma consistency scores. 3 is the number 
% of features in the gamma consistency metric -- GC1 (index=1), 
% GC2 (index=2), GC3 (index=3).
%

function [gcsorted] = gammaConsistency(spectrogram_mat, freq)

lgamma = find(freq <= 54 & freq >= 36);
hgamma1 = find(freq <= 88 & freq >= 66);
hgamma2 = find(freq <= 114 & freq >= 90);
freqbands_cell = {lgamma, hgamma1, hgamma2};

num_bands = length(freqbands_cell);

bandcombs = combnk([1:num_bands], 2); % all possible pairs
gcscore = zeros(size(bandcombs,1), 1);

% find the mean band power for the different bands
allavg = zeros(size(spectrogram_mat,1), num_bands);
for bn = 1:num_bands
    allavg(:,bn) = mean(mean(spectrogram_mat(:,freqbands_cell{bn},:),3),2);
end

% find how consistent signal in subbands of gamma is
for cn = 1:size(bandcombs,1);
    gcscore(cn,1) = corr(allavg(:,bandcombs(cn,1)), allavg(:,bandcombs(cn,2)));
end

gcsorted = sort(abs(gcscore),'descend');

end

