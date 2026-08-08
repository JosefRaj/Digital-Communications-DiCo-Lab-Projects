% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Student starter function: demodulate.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.7
%
% Converts the real RF receive signal to the complex ECB domain.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function ecb_signal = demodulate(rf_signal, f_c, f_s)
%DEMODULATE Convert a real-valued RF signal to complex baseband.

rf_signal = rf_signal(:).';
validateattributes(rf_signal, {'numeric'}, ...
    {'vector', 'nonempty', 'real', 'finite'});
validateattributes(f_c, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
validateattributes(f_s, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
assert(f_s > 2*f_c, 'The sampling frequency must be larger than 2*f_c.');

% Use exactly the same time convention as in modulate.m.
t = (0:numel(rf_signal)-1) / f_s;

% TODO(L-2.7): Implement coherent I/Q demodulation.
ecb_signal = sqrt(2).* rf_signal .* cos(2*pi*f_c*t) - sqrt(2).* 1j * rf_signal .* sin(2*pi*f_c*t);


if isempty(ecb_signal)
    error('DICO:NotImplemented', ...
        'Complete demodulate.m for Lab Exercise L-2.7.');
end

ecb_signal = ecb_signal(:).';
assert(numel(ecb_signal) == numel(rf_signal), ...
    'The RF and ECB signals must have the same number of samples.');
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
