% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Student starter function: mapBitsToSymbols.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.1
%
% Maps binary labels to PAM/QAM symbols using Natural Mapping.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function PAM_symbols = mapBitsToSymbols(bitvector, PAM_type)
%MAPBITSTOSYMBOLS Natural mapping for BPSK, 4-QAM, and bipolar 8-ASK.

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

% TODO(L-2.1): Implement Natural Mapping without qammod or pammod.
%PAM_symbols = [];

switch PAM_type
    case 'BPSK'
        PAM_symbols = 2*bitvector -1;
    case '8ASKbipolar'
        bitspersymbol = reshape(bitvector,3,[])';
        decimalvalue = bitspersymbol(:,1)*4 +bitspersymbol(:,2)*2 + bitspersymbol(:,3);
        PAM_symbols = 2*decimalvalue - 7;
    case '4QAM'
        bitspersymbol = reshape(bitvector,2,[])';
        I = 2*bitspersymbol(:,1) -1;
        Q = 2*bitspersymbol(:,2) -1;
        PAM_symbols = I + 1j*Q;


if isempty(PAM_symbols)
    error('DICO:NotImplemented', ...
        'Complete mapBitsToSymbols.m for Lab Exercise L-2.1.');
end

PAM_symbols = PAM_symbols(:).';
assert(numel(PAM_symbols) == numel(bitvector)/bitsPerSymbol, ...
    'The mapper returned an unexpected number of symbols.');
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
