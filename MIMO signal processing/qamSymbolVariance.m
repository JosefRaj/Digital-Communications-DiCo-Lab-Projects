% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: qamSymbolVariance.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function sigma_x_2 = qamSymbolVariance(M)
%QAMSYMBOLVARIANCE Average energy E{|x|^2} of unnormalized square M-QAM.

validateSquareQAM(M);
sigma_x_2 = (2/3) * (double(M) - 1);
end

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
