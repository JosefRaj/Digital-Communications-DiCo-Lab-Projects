% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Provided function: MatchedFilter.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.8 - provided, do not edit
%
% Matched RRC receive filter corresponding to pulseShape.m.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function filteredSignal = MatchedFilter(inputSignal, f_b, f_s)
%MATCHEDFILTER Apply the receive-side matched RRC filter.

inputSignal = inputSignal(:).';
validateattributes(inputSignal, {'numeric'}, {'vector', 'nonempty', 'finite'});
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

rrc = rcosdesign(alpha, spanInSymbols, samplesPerSymbol);
filterLength = numel(rrc);
groupDelay = (filterLength - 1) / 2;

filterInput = [inputSignal, zeros(1, filterLength)];
completeOutput = filter(rrc(:), 1, filterInput);

% Remove the group delay and the appended filter transient.
firstSample = groupDelay + 1;
lastSample = numel(completeOutput) - filterLength + groupDelay;
filteredSignal = completeOutput(firstSample:lastSample);
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
