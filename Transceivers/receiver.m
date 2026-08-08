% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Student starter function: receiver.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.7 to L-2.10
%
% Combines RF demodulation, matched filtering, sampling, and demapping.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function receivedBits = receiver(recSignal, PAM_type, GrayMappingOn, f_b, f_c, f_s)
%RECEIVER Recover a binary sequence from the real-valued RF signal.
recSignal = recSignal(:).';
validateattributes(recSignal, {'numeric'}, {'vector', 'nonempty', 'real', 'finite'});
PAM_type = validatestring(PAM_type, {'BPSK', '4QAM', '8ASKbipolar'});
validateattributes(GrayMappingOn, {'logical', 'numeric'}, {'scalar'});
assert(GrayMappingOn == 0 || GrayMappingOn == 1, ...
    'GrayMappingOn must be false/0 or true/1.');
validateattributes(f_b, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
validateattributes(f_c, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});
validateattributes(f_s, {'numeric'}, {'real', 'finite', 'positive', 'scalar'});

% TODO(L-2.7): Demodulate the RF signal into the ECB domain.
ecbSignal = demodulate(recSignal, f_c, f_s);

if isempty(ecbSignal)
    error('DICO:NotImplemented', ...
        'Add the demodulate call in receiver.m (L-2.7).');
end

% TODO(L-2.8): Apply matched filtering and downsampling.
filteredSignal = MatchedFilter(ecbSignal, f_b, f_s);
PAM_symbols = Downsample(filteredSignal, f_s/f_b);

if isempty(filteredSignal) || isempty(PAM_symbols)
    error('DICO:NotImplemented', ...
        'Add MatchedFilter and Downsample in receiver.m (L-2.8).');
end

% TODO(L-2.9/L-2.10): Select the natural or Gray demapper.
receivedBits = [];
if GrayMappingOn == 0
    receivedBits = mapSymbolsToBits(PAM_symbols, PAM_type);
else 
    receivedBits = mapSymbolsToBits_Gray(PAM_symbols, PAM_type);
end

if isempty(receivedBits)
    error('DICO:NotImplemented', ...
        'Complete the demapping step in receiver.m (L-2.9/L-2.10).');
end

receivedBits = receivedBits(:).';
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
