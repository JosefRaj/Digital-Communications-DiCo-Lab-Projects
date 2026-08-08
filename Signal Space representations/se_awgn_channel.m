% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: se_awgn_channel.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function receivedSignal = se_awgn_channel(transmitSignal, EbN0_dB, numberOfBits)
%SE_AWGN_CHANNEL Add AWGN for a requested information-bit Eb/N0.
%   The finite-record bit energy is
%       Eb = sum(abs(transmitSignal).^2) / numberOfBits.
%   For complex signals, circular complex noise with E{|n|^2}=N0 is used.
%   For real signals, real noise with variance N0/2 is used.

narginchk(3, 3);
transmitSignal = transmitSignal(:).';
validateattributes(EbN0_dB, {'numeric'}, {'scalar','real'}, mfilename, 'EbN0_dB');
validateattributes(numberOfBits, {'numeric'}, ...
    {'scalar','integer','positive'}, mfilename, 'numberOfBits');
if isempty(transmitSignal)
    error('se_awgn_channel:EmptySignal', 'The transmit signal must not be empty.');
end

Eb = sum(abs(transmitSignal).^2) / numberOfBits;
N0 = Eb / 10^(EbN0_dB/10);

if isreal(transmitSignal)
    noise = sqrt(N0/2) * randn(size(transmitSignal));
else
    noise = sqrt(N0/2) * (randn(size(transmitSignal)) + ...
                         1i*randn(size(transmitSignal)));
end
receivedSignal = transmitSignal + noise;
end

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
