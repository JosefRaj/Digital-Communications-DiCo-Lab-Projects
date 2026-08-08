% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Student starter function: channel.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.6
%
% Adds real-valued AWGN with a specified Eb/N0 to the RF signal.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function recSignal = channel(traSignal, EbN0_dB, M, f_s, f_b)
%CHANNEL Add AWGN to the real-valued transmit signal.

traSignal = traSignal(:).';
validateattributes(traSignal, {'numeric'}, ...
    {'vector', 'nonempty', 'real', 'finite'});
validateattributes(EbN0_dB, {'numeric'}, {'real', 'finite', 'scalar'});
validateattributes(M, {'numeric'}, {'real', 'finite', 'integer', '>=', 2, 'scalar'});
assert(abs(log2(M) - round(log2(M))) < 10*eps(log2(M)), ...
    'M must be a power of two.');
validateattributes(f_s, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
validateattributes(f_b, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
assert(exist('noiseGen', 'file') ~= 0, ...
    'The protected black-box file noiseGen.p is missing.');

% TODO(L-2.6): Calculate
%   1) mean signal power,
%   2) energy per information bit E_b,
%   3) noise spectral density N_0.
meanSignalPower = mean(abs(traSignal).^2);
E_b = meanSignalPower/(f_b * log2(M));
EbN0 = 10^(EbN0_dB/10);
N_0 = E_b/EbN0;

if isempty(N_0)
    error('DICO:NotImplemented', ...
        'Calculate N_0 in channel.m for Lab Exercise L-2.6.');
end

validateattributes(N_0, {'numeric'}, {'real', 'finite', 'nonnegative', 'scalar'});
noise = noiseGen(numel(traSignal), N_0, f_s);
noise = noise(:).';
assert(isreal(noise) && numel(noise) == numel(traSignal), ...
    'noiseGen must return a real vector with the same length as traSignal.');

recSignal = traSignal + noise;
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
