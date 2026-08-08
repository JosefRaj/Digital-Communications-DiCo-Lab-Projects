% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: GetQAM.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function x = GetQAM(r, c, M)
%GETQAM Generate an r-by-c matrix of unnormalized square-QAM symbols.
%
% Supported at least: 4-QAM and 16-QAM.
% Alphabet levels per real dimension are
%   -(sqrt(M)-1), -(sqrt(M)-3), ..., +(sqrt(M)-1).

narginchk(3,3);
validateattributes(r, {'numeric'}, {'real','scalar','integer','positive'});
validateattributes(c, {'numeric'}, {'real','scalar','integer','positive'});
sqrtM = validateSquareQAM(M); %#ok<NASGU>

% TODO L-5.1:
% 1. Construct the sqrt(M) odd integer levels on each axis.
% 2. Draw independent, equiprobable inphase and quadrature indices.
% 3. Return an r-by-c complex matrix.


% Number of levels per dimension
sqrtM = sqrt(M);

% Generate odd integer levels
levels = -(sqrtM-1):2:(sqrtM-1);

% Random indices for real part
I = randi(sqrtM,r,c);

% Random indices for imaginary part
Q = randi(sqrtM,r,c);

% Generate complex QAM symbols
x = levels(I) + 1i*levels(Q);



%error('GetQAM:NotImplemented', ...
   % 'Complete Lab Exercise L-5.1 in GetQAM.m.');
%end

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
