% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: map_bits_qam.m
% Purpose: Provided robust Gray-labelled square-QAM mapper.
% =========================================================================
function PAMSymbols = map_bits_qam(bitvector, M)
%MAP_BITS_QAM Map a binary row vector to Gray-labelled square-QAM symbols.
%
% The output uses unit average constellation power. Do not add padding here;
% padding is handled centrally in Simulation_OFDM.m.

validateattributes(bitvector, {'numeric', 'logical'}, {'vector', 'nonempty'}, ...
    mfilename, 'bitvector');
bitvector = double(reshape(bitvector, 1, []));
if any(bitvector ~= 0 & bitvector ~= 1)
    error('DICO:OFDM:NonBinaryInput', 'bitvector must contain only 0 and 1.');
end

validateattributes(M, {'numeric'}, {'scalar', 'integer', '>=', 4}, mfilename, 'M');
bitsPerSymbol = log2(M);
if bitsPerSymbol ~= round(bitsPerSymbol) || sqrt(M) ~= round(sqrt(M))
    error('DICO:OFDM:UnsupportedQAM', ...
        'M must be a power-of-two square-QAM order such as 4, 16, or 64.');
end
if mod(numel(bitvector), bitsPerSymbol) ~= 0
    error('DICO:OFDM:InvalidBitLength', ...
        'The bit-vector length must be a multiple of log2(M) = %d.', bitsPerSymbol);
end

bitMatrix = reshape(bitvector, bitsPerSymbol, []).';
symbolIndices = bi2de(bitMatrix, 'left-msb');
PAMSymbols = qammod(symbolIndices, M, 'gray', 'UnitAveragePower', true).';
PAMSymbols = reshape(PAMSymbols, 1, []);
end

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
