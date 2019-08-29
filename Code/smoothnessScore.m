%% smoothnessScore
% calculates the smoothness score i.e., 1-lag autocorrelation of the mean
% band power change for different frequency bands.
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
% smooth_score - a 2x1 matrix containing smoothness score for the input electrode. 
% 2 corresponds to bands (low theta= index 1, high theta= index 2)
%

function [smooth_score] = smoothnessScore(spectrogram_mat, freq)

% find the index of the frequency bands of interest in the spectrogram
lowtheta = find(freq <= 4 & freq >= 2);
hightheta = find(freq <= 8 & freq >= 6);

freqbands_cell = {lowtheta, hightheta};
num_bands = length(freqbands_cell);

% find the smoothness in the frequency band
smooth_score = zeros(num_bands, 1);
   
for bn = 1:length(check_band)
    % find the mean band power changes
    allavg = mean(mean(spectrogram_mat(:,freqbands_cell{bn},:),3),2);
    
    % find smoothness score
    crlag = 1;
    smscore = corr(allavg((1+crlag):end), allavg(1:(end-crlag)));

    smooth_score(bn, 1) = smscore;
end

end