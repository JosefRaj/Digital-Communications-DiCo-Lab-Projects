% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Provided function: pulseShape.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.4 - provided, do not edit
%
% Root-raised-cosine pulse shaping for the complex baseband signal.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function ecbSignal = pulseShape(PAM_symbols, f_b, f_s)
%PULSESHAPE Upsample and filter the PAM symbols with an RRC pulse.

PAM_symbols = PAM_symbols(:).';
validateattributes(PAM_symbols, {'numeric'}, {'vector', 'nonempty', 'finite'});
validateattributes(f_b, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
validateattributes(f_s, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});

alpha = 0.21;
spanInSymbols = 30;
samplesPerSymbol = f_s / f_b;

assert(abs(samplesPerSymbol - round(samplesPerSymbol)) < 10*eps(samplesPerSymbol), ...
    'f_s/f_b must be an integer.');
samplesPerSymbol = round(samplesPerSymbol);
assert(mod(samplesPerSymbol, 2) == 0, ...
    'f_s/f_b must be even for the supplied sampling convention.');
assert(exist('rcosdesign', 'file') ~= 0, ...
    'rcosdesign is required (Communications Toolbox).');
assert(exist('upsample', 'file') ~= 0, ...
    'upsample is required (Signal Processing Toolbox).');

rrc = rcosdesign(alpha, spanInSymbols, samplesPerSymbol);
filterLength = numel(rrc);
groupDelay = (filterLength - 1) / 2;

upsampledSymbols = upsample(PAM_symbols, samplesPerSymbol, samplesPerSymbol / 2);
filterInput = [upsampledSymbols, zeros(1, filterLength)];
filteredSignal = filter(rrc(:), 1, filterInput);

% Remove the group delay and the appended filter transient.
firstSample = groupDelay + 1;
lastSample = numel(filteredSignal) - filterLength + groupDelay;
ecbSignal = filteredSignal(firstSample:lastSample);
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
