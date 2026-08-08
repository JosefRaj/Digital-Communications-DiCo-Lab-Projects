% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Student starter function: mapBitsToSymbols_Gray.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.2
%
% Maps binary labels to PAM/QAM symbols using Gray Mapping.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function PAM_symbols = mapBitsToSymbols_Gray(bitvector, PAM_type)
%MAPBITSTOSYMBOLS_GRAY Gray mapping for BPSK, 4-QAM, and bipolar 8-ASK.

bitvector = bitvector(:).';
validateattributes(bitvector, {'numeric', 'logical'}, ...
    {'vector', 'nonempty', 'real', 'finite'});
assert(all(bitvector == 0 | bitvector == 1), ...
    'bitvector must contain only 0 and 1.');
bitvector = double(bitvector);
PAM_type = validatestring(PAM_type, {'BPSK', '4QAM', '8ASKbipolar'});
[~, bitsPerSymbol] = getModulationOrder(PAM_type);
assert(mod(numel(bitvector), bitsPerSymbol) == 0, ...
    'The bit-vector length must be a multiple of log2(M). Pad in simulation.m.');

% TODO(L-2.2): Implement Gray Mapping without qammod or pammod.
switch PAM_type
    case 'BPSK'
        PAM_symbols = 2*bitvector -1;
    case '8ASKbipolar'
        bitspersymbol = reshape(bitvector,3,[])';
        B1 = bitspersymbol(:,1);
        B2 = xor(B1,bitspersymbol(:,2));
        B3 = xor(B2,bitspersymbol(:,3));
        decimalvalue = B1*4 +B2*2 + B3;
        PAM_symbols = 2*decimalvalue - 7;
    case '4QAM'
        bitspersymbol = reshape(bitvector,2,[])';
        I = 2*bitspersymbol(:,1) -1;
        Q = 2*bitspersymbol(:,2) -1;
        PAM_symbols = I + 1j*Q;

if isempty(PAM_symbols)
    error('DICO:NotImplemented', ...
        'Complete mapBitsToSymbols_Gray.m for Lab Exercise L-2.2.');
end

PAM_symbols = PAM_symbols(:).';
assert(numel(PAM_symbols) == numel(bitvector)/bitsPerSymbol, ...
    'The mapper returned an unexpected number of symbols.');
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
