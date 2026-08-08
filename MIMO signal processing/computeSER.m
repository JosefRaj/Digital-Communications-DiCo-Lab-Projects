% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: computeSER.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function SER = computeSER(transmittedSymbols, estimatedSymbols)
%COMPUTESER Compute the symbol error ratio for equal-sized arrays.

narginchk(2,2);
if ~isequal(size(transmittedSymbols), size(estimatedSymbols))
    error('computeSER:SizeMismatch', ...
        'Transmitted and estimated symbol matrices must have equal size.');
end
if isempty(transmittedSymbols)
    error('computeSER:EmptyInput', 'Symbol matrices must not be empty.');
end
SER = nnz(transmittedSymbols ~= estimatedSymbols) / numel(transmittedSymbols);
end

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
