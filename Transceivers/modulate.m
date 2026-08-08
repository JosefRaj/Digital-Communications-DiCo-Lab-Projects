% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Student starter function: modulate.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.5
%
% Converts the complex equivalent baseband signal to a real RF signal.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function rf_signal = modulate(ecb_signal, f_c, f_s)
%MODULATE Convert a complex ECB signal to a real-valued RF signal.

ecb_signal = ecb_signal(:).';
validateattributes(ecb_signal, {'numeric'}, {'vector', 'nonempty', 'finite'});
validateattributes(f_c, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
validateattributes(f_s, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
assert(f_s > 2*f_c, 'The sampling frequency must be larger than 2*f_c.');

% Time vector starts at t = 0 to avoid an unnecessary fixed phase offset.
t = (0:numel(ecb_signal)-1) / f_s;

% TODO(L-2.5): Implement the I/Q modulation formula from the lecture notes.
I = real(ecb_signal);
Q = imag(ecb_signal);
rf_signal = I.* sqrt(2).* cos(2*pi*f_c*t) - Q .* sqrt(2) .* sin(2*pi*f_c*t);

if isempty(rf_signal)
    error('DICO:NotImplemented', ...
        'Complete modulate.m for Lab Exercise L-2.5.');
end

rf_signal = rf_signal(:).';
assert(isreal(rf_signal), 'modulate must return a real-valued RF signal.');
assert(numel(rf_signal) == numel(ecb_signal), ...
    'The RF and ECB signals must have the same number of samples.');
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
