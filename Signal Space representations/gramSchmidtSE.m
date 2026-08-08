% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: gramSchmidtSE.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function [basisFunctions, coefficients, selectionOrder] = ...
    gramSchmidtSE(signalElements, mode, tolerance)
%GRAMSCHMIDTSE Orthogonalize row-wise signal elements.
%
% Required output convention:
%   signalElements = coefficients.' * basisFunctions
% where basisFunctions contains one orthonormal basis function per row.
%
% mode may be 'incremental' or 'sorted-by-energy'.

narginchk(1,3);
if nargin < 2 || isempty(mode)
    mode = 'incremental';
end
if nargin < 3 || isempty(tolerance)
    tolerance = 1e-12;
end
validateattributes(signalElements, {'numeric'}, {'2d','nonempty'});
validateattributes(tolerance, {'numeric'}, {'scalar','real','positive'});
mode = lower(strtrim(char(mode)));
if ~ismember(mode, {'incremental','sorted-by-energy'})
    error('gramSchmidtSE:UnknownMode', ...
        'mode must be incremental or sorted-by-energy.');
end

% TODO L-4.6:
% Implement the modified Gram-Schmidt procedure. Dependent signal elements
% must not introduce additional basis functions. Return the coefficients in
% the convention stated above.

basisFunctions = [];
coefficients = [];
selectionOrder = [];
basisCount = 0;

for i = 1:size(signalElements,1)
    v = signalElements(i,:);
    coeff = zeros(basisCount,1);
    for j = 1:basisCount
        coeff(j) = basisFunctions(j,:) * v';
        v = v - coeff(j)*basisFunctions(j,:);

    end

    energy = norm(v);

    if energy > tolerance

        basisCount = basisCount + 1;

        basisFunctions(basisCount,:) = v/energy;

        coefficients(1:basisCount-1,i) = coeff;

        coefficients(basisCount,i) = energy;

        selectionOrder(end+1) = i;

    else

        coefficients(1:basisCount,i) = coeff;

    end

end


%error('gramSchmidtSE:NotImplemented', ...
  %  'Complete Lab Exercise L-4.6 in gramSchmidtSE.m.');
end

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
