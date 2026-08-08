% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: validateSquareQAM.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function sqrtM = validateSquareQAM(M)
%VALIDATESQUAREQAM Validate an unnormalized square-QAM constellation size.

narginchk(1,1);
validateattributes(M, {'numeric'}, {'real','scalar','integer','>=',4});
sqrtM = sqrt(double(M));
if sqrtM ~= round(sqrtM) || mod(round(sqrtM),2) ~= 0 || ...
        log2(double(M)) ~= round(log2(double(M)))
    error('validateSquareQAM:InvalidOrder', ...
        'M must be a standard square-QAM order (4, 16, 64, 256, ...).');
end
sqrtM = round(sqrtM);
end

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
