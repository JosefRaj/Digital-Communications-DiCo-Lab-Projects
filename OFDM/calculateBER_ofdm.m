% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: calculateBER_ofdm.m
% Purpose: Provided BER calculation with input checks.
% =========================================================================
function BER = calculateBER_ofdm(transmittedBits, receivedBits)
%CALCULATEBER_OFDM Calculate the bit error ratio for equal-length vectors.

validateattributes(transmittedBits, {'numeric', 'logical'}, {'vector'}, ...
    mfilename, 'transmittedBits');
validateattributes(receivedBits, {'numeric', 'logical'}, {'vector'}, ...
    mfilename, 'receivedBits');
transmittedBits = reshape(transmittedBits, 1, []);
receivedBits = reshape(receivedBits, 1, []);

if numel(transmittedBits) ~= numel(receivedBits)
    error('DICO:OFDM:BERLengthMismatch', ...
        'Transmitted and received bit vectors must have equal lengths.');
end
if isempty(transmittedBits)
    error('DICO:OFDM:EmptyBERInput', 'The bit vectors must not be empty.');
end

BER = nnz(transmittedBits ~= receivedBits) / numel(transmittedBits);
end

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
