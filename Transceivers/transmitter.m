% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Student starter function: transmitter.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.1, L-2.2, L-2.4, L-2.5
%
% Combines mapping, pulse shaping, and RF modulation.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function transmittedSignal = transmitter(bitvector, PAM_type, GrayMappingOn, f_b, f_c, f_s)
%TRANSMITTER Generate the real-valued RF transmit signal.

bitvector = validateBitVectorLocal(bitvector, 'bitvector');
PAM_type = validatestring(PAM_type, {'BPSK', '4QAM', '8ASKbipolar'});
validateattributes(GrayMappingOn, {'logical', 'numeric'}, {'scalar'});
assert(GrayMappingOn == 0 || GrayMappingOn == 1, ...
    'GrayMappingOn must be false/0 or true/1.');
validateattributes(f_b, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
validateattributes(f_c, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
validateattributes(f_s, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});

% TODO(L-2.1/L-2.2): Select the natural or Gray mapper.
%PAM_symbols = [];

if GrayMappingOn == 0
    PAM_symbols = mapBitsToSymbols(bitvector, PAM_type);
else 
    PAM_symbols = mapBitsToSymbols_Gray(bitvector, PAM_type);
end

if isempty(PAM_symbols)
    error('DICO:NotImplemented', ...
        'Complete the mapping step in transmitter.m (L-2.1/L-2.2).');
end

% TODO(L-2.4): Apply pulse shaping.
ecbSignal = pulseShape(PAM_symbols, f_b, f_s);

if isempty(ecbSignal)
    error('DICO:NotImplemented', ...
        'Add the pulseShape call in transmitter.m (L-2.4).');
end

% TODO(L-2.5): Modulate the ECB signal to RF.
transmittedSignal = modulate(ecbSignal, f_c, f_s);

if isempty(transmittedSignal)
    error('DICO:NotImplemented', ...
        'Add the modulate call in transmitter.m (L-2.5).');
end
end

function bits = validateBitVectorLocal(bits, variableName)
bits = bits(:).';
validateattributes(bits, {'numeric', 'logical'}, ...
    {'vector', 'nonempty', 'real', 'finite'}, mfilename, variableName);
assert(all(bits == 0 | bits == 1), '%s must contain only 0 and 1.', variableName);
bits = double(bits);
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
