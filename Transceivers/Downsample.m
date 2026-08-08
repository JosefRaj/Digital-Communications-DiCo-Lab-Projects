% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Provided function: Downsample.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.8 - provided, do not edit
%
% Samples the matched-filter output at the prescribed symbol instants.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function PAM_symbols = Downsample(inputSignal, downsamplingFactor)
%DOWNSAMPLE Extract one sample per symbol.

inputSignal = inputSignal(:).';
validateattributes(inputSignal, {'numeric'}, {'vector', 'nonempty', 'finite'});
validateattributes(downsamplingFactor, {'numeric'}, ...
    {'real', 'finite', 'positive', 'scalar'});
assert(downsamplingFactor == round(downsamplingFactor), ...
    'downsamplingFactor must be an integer.');
downsamplingFactor = round(downsamplingFactor);
assert(mod(downsamplingFactor, 2) == 0, ...
    'downsamplingFactor must be even for the supplied sampling phase.');

firstSample = 1 + downsamplingFactor / 2;
assert(firstSample <= numel(inputSignal), ...
    'The input signal is too short for the selected downsampling factor.');

PAM_symbols = inputSignal(firstSample:downsamplingFactor:end);
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
