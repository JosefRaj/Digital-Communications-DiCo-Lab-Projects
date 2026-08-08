% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Student starter function: mapSymbolsToBits.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: L-2.9
%
% Nearest-neighbour decision and Natural demapping.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function bitvector = mapSymbolsToBits(PAM_symbols, PAM_type)
%MAPSYMBOLSTOBITS Natural demapping after a nearest-point decision.

PAM_symbols = PAM_symbols(:).';
validateattributes(PAM_symbols, {'numeric'}, {'vector', 'nonempty', 'finite'});
PAM_type = validatestring(PAM_type, {'BPSK', '4QAM', '8ASKbipolar'});
[~, bitsPerSymbol] = getModulationOrder(PAM_type);

% TODO(L-2.9): Decide on the nearest valid symbol and apply Natural demapping.
% Do not use qamdemod or pamdemod.

switch PAM_type
    case 'BPSK'
        bitvector = zeros(1,length(PAM_symbols));
        for k=1:length(PAM_symbols)
            if real(PAM_symbols(k) < 0)
                bitvector(k)=0;
            else 
                bitvector(k)=1;
            end
        end
    case '8ASKbipolar'
        levels = [-7 -5 -3 -1 1 3 5 7];
        bitvector= [];
        for k=1:length(PAM_symbols)
            symbol = real(PAM_symbols(k));
            [~, index] = min(abs(symbol - levels));

            decimal = index - 1;
            b1 = floor (decimal/4);
            decimal = mod(decimal,4);
            b2 = floor(decimal/2);
            b3 = mod(decimal,2);
            bitvector = [bitvector b1 b2 b3];
        end

    case '4QAM'
        bitvector = [];
        for k=1:length(PAM_symbols)
            symbol = PAM_symbols(k);
        
           if real(symbol < 0) && imag(symbol) < 0
                bits = [0 0];
           elseif real(symbol < 0) && imag(symbol) > 0
                bits = [0 1];
           elseif real(symbol > 0) && imag(symbol) > 0
                bits = [1 1];
           elseif real(symbol > 0) && imag(symbol) < 0
                bits = [1 0];
           end

           bitvector = [bitvector bits];
        
        end


end

if isempty(bitvector)
    error('DICO:NotImplemented', ...
        'Complete mapSymbolsToBits.m for Lab Exercise L-2.9.');
end

bitvector = bitvector(:).';
assert(all(bitvector == 0 | bitvector == 1), ...
    'The demapper must return only 0 and 1.');
assert(numel(bitvector) == numel(PAM_symbols)*bitsPerSymbol, ...
    'The demapper returned an unexpected number of bits.');
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
