% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: ofdm_awgn_channel.m
% Purpose: Provided transparent AWGN helper for the OFDM chain.
% =========================================================================
function receivedSignal = ofdm_awgn_channel(channelOutput, referenceSignal, ...
    EbN0_dB, numberOfTransmittedBits)
%OFDM_AWGN_CHANNEL Add complex AWGN with Eb/N0 referenced to the transmitter.
%
% The reference signal is the OFDM signal before the dispersive channel.
% This avoids silently renormalizing the noise after channel attenuation or
% amplification. The cyclic-prefix energy is included automatically.

validateattributes(channelOutput, {'numeric'}, {'vector', 'nonempty'}, ...
    mfilename, 'channelOutput');
validateattributes(referenceSignal, {'numeric'}, {'vector', 'nonempty'}, ...
    mfilename, 'referenceSignal');
validateattributes(EbN0_dB, {'numeric'}, {'scalar', 'real', 'finite'}, ...
    mfilename, 'EbN0_dB');
validateattributes(numberOfTransmittedBits, {'numeric'}, ...
    {'scalar', 'integer', 'positive'}, mfilename, 'numberOfTransmittedBits');

channelOutput = reshape(channelOutput, 1, []);
referenceSignal = reshape(referenceSignal, 1, []);
if numel(channelOutput) ~= numel(referenceSignal)
    error('DICO:OFDM:NoiseReferenceLength', ...
        'channelOutput and referenceSignal must have equal lengths.');
end

Eb = sum(abs(referenceSignal).^2) / numberOfTransmittedBits;
N0 = Eb / 10^(EbN0_dB/10);
noise = sqrt(N0/2) * ...
    (randn(size(channelOutput)) + 1i*randn(size(channelOutput)));
receivedSignal = channelOutput + noise;
end

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
