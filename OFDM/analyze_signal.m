% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: analyze_signal.m
% Purpose: Provided time- and frequency-domain analysis helper.
% =========================================================================
function analyze_signal(block, sampleRate)
%ANALYZE_SIGNAL Plot an estimated two-sided PSD and a time-domain excerpt.
%
% analyze_signal(block) uses normalized sample frequency.
% analyze_signal(block, sampleRate) labels the frequency axis in hertz.

if nargin < 1
    error('DICO:OFDM:MissingInput', 'Use analyze_signal(block [, sampleRate]).');
end
if nargin < 2 || isempty(sampleRate)
    sampleRate = 1;
    frequencyLabel = 'Normalized frequency (cycles/sample)';
else
    validateattributes(sampleRate, {'numeric'}, {'scalar', 'positive'}, ...
        mfilename, 'sampleRate');
    frequencyLabel = 'Frequency (Hz)';
end
validateattributes(block, {'numeric'}, {'vector', 'nonempty'}, mfilename, 'block');
block = reshape(block, 1, []);

if numel(block) < 5e4
    warning('DICO:OFDM:ShortAnalysisBlock', ...
        ['The block contains only %d samples. For a smoother spectrum, ' ...
         'use the 1,200,000-bit experiment suggested in L-4.6.'], numel(block));
end

segmentLength = min(4096, numel(block));
if segmentLength < 32
    segmentLength = numel(block);
end
window = hann(segmentLength, 'periodic');
overlap = floor(segmentLength / 2);
[psdEstimate, frequency] = pwelch(block, window, overlap, ...
    segmentLength, sampleRate, 'centered');

figure;
plot(frequency, 10*log10(psdEstimate + eps));
grid on;
xlabel(frequencyLabel);
ylabel('PSD estimate (dB)');
title('OFDM signal: frequency-domain analysis');

numberOfDisplayedSamples = min(2000, numel(block));
timeIndex = (0:numberOfDisplayedSamples-1) / sampleRate;
figure;
plot(timeIndex, real(block(1:numberOfDisplayedSamples)));
hold on;
plot(timeIndex, imag(block(1:numberOfDisplayedSamples)));
grid on;
xlabel('Time (s or normalized sample time)');
ylabel('Amplitude');
legend('Real part', 'Imaginary part', 'Location', 'best');
title('OFDM signal: time-domain excerpt');
end

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
