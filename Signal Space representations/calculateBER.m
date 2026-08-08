% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: calculateBER.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function BER = calculateBER(traBits, recBits)
%CALCULATEBER Calculate the bit error ratio of two binary vectors.

narginchk(2, 2);
traBits = traBits(:).';
recBits = recBits(:).';

if numel(traBits) ~= numel(recBits)
    error('calculateBER:LengthMismatch', ...
        'Transmit and receive vectors must have the same length.');
end
if isempty(traBits)
    error('calculateBER:EmptyInput', 'The bit vectors must not be empty.');
end
if any((traBits ~= 0) & (traBits ~= 1)) || ...
        any((recBits ~= 0) & (recBits ~= 1))
    error('calculateBER:NonBinaryInput', ...
        'Both input vectors must contain only zeros and ones.');
end

BER = mean(traBits ~= recBits);
end

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
