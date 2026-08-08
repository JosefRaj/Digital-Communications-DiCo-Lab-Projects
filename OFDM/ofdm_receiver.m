% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: ofdm_receiver.m
% Purpose: Incomplete OFDM receiver for L-4.8 to L-4.11.
% =========================================================================
function recBits = ofdm_receiver(recSignal, M, channelProfile)
%OFDM_RECEIVER Student implementation for Lab Exercises L-4.8--L-4.11.

if nargin < 3
    channelProfile = 'profile1';
end
validateattributes(recSignal, {'numeric'}, {'vector', 'nonempty'}, ...
    mfilename, 'recSignal');
recSignal = reshape(recSignal, 1, []);
[D, ~] = ofdm_parameters(channelProfile); %#ok<ASGLU>

recBits = [];

% TODO(L-4.8):
% Split the serial receive vector into OFDM blocks and remove the cyclic
% prefix. Use the same prefix length as at the transmitter.

cpLength = 5;

% Total samples per OFDM block
blockLength = D + cpLength;

% Split received signal into OFDM blocks
recBlocks = reshape(recSignal, blockLength, []).';
%recBlocks = reshape(recSignal, [], blockLength);

% Remove cyclic prefix
recBlocks = recBlocks(:, cpLength+1:end);

% TODO(L-4.9):
% Apply a D-point Fourier transform to every block.
PAMSymbols = fft(recBlocks, D, 2);

% TODO(L-4.10):
% Equalize the D subchannels using feq(PAMSymbols, channelProfile).
PAMSymbols = feq(PAMSymbols, channelProfile);

% TODO(L-4.11):
% Serialize the equalized QAM symbols and call demap_bits_qam.
PAMSymbols = reshape(PAMSymbols.',1,[]);

% Demap QAM symbols back to bits
recBits = demap_bits_qam(PAMSymbols,M);
%recBits = reshape(recBits, 1, []);

%if isempty(recBits)
%    error('DICO:OFDM:TodoReceiver', ...
     %   'Complete Lab Exercises L-4.8 to L-4.11 in ofdm_receiver.m.');
%end
%recBits = reshape(recBits, 1, []);
%end

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
