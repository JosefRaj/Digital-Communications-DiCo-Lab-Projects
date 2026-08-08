% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: QuantQAM.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function a_hat = QuantQAM(z, M)
%QUANTQAM Quantize every entry of z to the nearest square-QAM point.
%
% The input must not be normalized from its observed block maximum. Decision
% thresholds are fixed by the specified constellation.

narginchk(2,2);
validateattributes(z, {'numeric'}, {'nonempty'});
sqrtM = validateSquareQAM(M); %#ok<NASGU>

% TODO L-5.2:
% 1. Quantize real(z) and imag(z) independently to odd integer levels.
% 2. Clip both decisions to +/-(sqrt(M)-1).
% 3. Recombine the two components into a complex matrix.

% Number of constellation levels
sqrtM = sqrt(M);

% Valid QAM levels
levels = -(sqrtM-1):2:(sqrtM-1);

% Separate real and imaginary parts
realPart = real(z);
imagPart = imag(z);

% Allocate output
realQuant = zeros(size(realPart));
imagQuant = zeros(size(imagPart));

% Quantize real part
for k = 1:numel(realPart)

    [~,idx] = min(abs(realPart(k)-levels));

    realQuant(k) = levels(idx);

end

% Quantize imaginary part
for k = 1:numel(imagPart)

    [~,idx] = min(abs(imagPart(k)-levels));

    imagQuant(k) = levels(idx);

end

% Combine quantized parts
a_hat = realQuant + 1i*imagQuant;


%error('QuantQAM:NotImplemented', ...
  %  'Complete Lab Exercise L-5.2 in QuantQAM.m.');
%end

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
