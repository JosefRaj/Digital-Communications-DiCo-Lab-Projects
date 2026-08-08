% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Student starter script: simulation.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.12 to L-2.16
%
% Main script for the complete transmitter-channel-receiver simulation.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
clear;
close all;
clc;

fprintf('============================================================\n');
fprintf(' DICO Lab Course | Project 2 | Summer 2026\n');
fprintf(' File-set ID: DICO-LAB2-S26-v1.0\n');
fprintf('============================================================\n');

%% Simulation parameters
% Select exactly one supported modulation type.
% PAM_type = 'BPSK';
% PAM_type = '4QAM';
%PAM_type = '8ASKbipolar';
for EbN0_dB = 0:1:15
    PAM_types = {'BPSK','4QAM','8ASKbipolar'}
    
    for k=1:length(PAM_types)
    PAM_type = PAM_types{k};
    
    % Derive M automatically. Do not set PAM_type and M independently.
    [M, bitsPerSymbol] = getModulationOrder(PAM_type);
 
        for GrayMappingOn = [false, true]
        %GrayMappingOn = true;       % false = Natural Mapping, true = Gray Mapping
%EbN0_dB = 10;
numberOfBits = 12e4;
f_b = 1e3;                  % symbol rate in baud
oversamplingFactor = 4;     % samples per carrier period
f_c = 5e3;                  % carrier frequency in Hz
f_s = f_c * oversamplingFactor;

%% Consistency checks
samplesPerSymbol = f_s / f_b;
assert(abs(samplesPerSymbol - round(samplesPerSymbol)) < 10*eps(samplesPerSymbol), ...
    'f_s/f_b must be an integer.');
samplesPerSymbol = round(samplesPerSymbol);
assert(mod(samplesPerSymbol, 2) == 0, ...
    'f_s/f_b must be even for the supplied Downsample function.');
assert(numberOfBits >= 1 && numberOfBits == round(numberOfBits), ...
    'numberOfBits must be a positive integer.');

%% Creation of a random bit stream
sourceBits = randi([0 1], 1, numberOfBits);

%% Zero-padding
% Padding is done only here. The mapper functions therefore receive a bit
% vector whose length is an integer multiple of log2(M).
numberOfPaddingBits = mod(-numel(sourceBits), bitsPerSymbol);
traBits = [sourceBits, zeros(1, numberOfPaddingBits)];

%% Transmitter
traSignal = transmitter(traBits, PAM_type, GrayMappingOn, f_b, f_c, f_s);

%% Channel
useChannel = true;
if useChannel
    recSignal = channel(traSignal, EbN0_dB, M, f_s, f_b);
else
    recSignal = traSignal;  % useful for a noise-free end-to-end test
end

%% Receiver
recBitsPadded = receiver(recSignal, PAM_type, GrayMappingOn, f_b, f_c, f_s);

% Remove bits corresponding to zero-padding before calculating the BER.
assert(numel(recBitsPadded) >= numel(sourceBits), ...
    'The receiver returned fewer bits than expected.');
recBits = recBitsPadded(1:numel(sourceBits));

%% Calculate BER
BER = calculateBER(sourceBits, recBits);
fprintf('PAM type: %s | Gray mapping: %d | Eb/N0: %.1f dB | BER: %.6g\n', ...
PAM_type, GrayMappingOn, EbN0_dB, BER);


            end
    end
end

%% Plots
% TODO(L-2.12): Plot the two-sided PSD of traSignal and recSignal.

figure;
title(PAM_type,'traSignal');
pwelch(traSignal, [], [], [], f_s, 'centered');
figure;
title(PAM_type,'recSignal');
pwelch(recSignal, [], [], [], f_s, 'centered');


% TODO(L-2.15/L-2.16): Extend this script with an Eb/N0 loop and BER plots.


% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
