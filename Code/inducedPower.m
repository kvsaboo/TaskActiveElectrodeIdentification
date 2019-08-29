%% inducedPower
% calculates the induced power in different bands from the mean band power 
% change for one electrode whose spectrograms are passed as input.
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
% ip_all: 6x1 matrix for induced power in band when all trials are used in
% calculation of mean band power. 6 bands are used - low theta (index=1), 
% high theta (index=2), alpha(index=3), beta (index=4), low gamma (index=5)
% and high gamma (index=6).

function [ip_all] = inducedPower(spectrogram_mat, freq)

% frequency bands of interest and their index in the spectrogram
lowtheta = find(freq <= 4 & freq >= 2);
hightheta = find(freq <= 8 & freq >= 6);
alpha = find(freq <= 14 & freq >= 10);
beta = find(freq <= 24 & freq >= 16);
lowgamma = find(freq <= 54 & freq >= 36);
highgamma = find(freq <= 114 & freq >= 66);

freqbands_cell = {lowtheta, hightheta, alpha, beta, lowgamma, highgamma};
num_bands = length(freqbands_cell);

% find the sme in the frequency bands
ip_all = zeros(num_bands,1);

for bn = 1:num_bands
    % find the mean band power changes
    sigavg = mean(mean(spectrogram_mat(:,freqbands_cell{bn},:),3),2);

    % find sum of absolute values
    ip_all(bn) = sum(abs(sigavg));
end

end

