% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: demap_bits_qam.m
% Purpose: Provided robust square-QAM decision and demapper.
% =========================================================================
function bitvector = demap_bits_qam(PAMSymbols, M)
%DEMAP_BITS_QAM Decide Gray-labelled square-QAM symbols and recover the bits.

validateattributes(PAMSymbols, {'numeric'}, {'vector', 'nonempty'}, ...
    mfilename, 'PAMSymbols');
PAMSymbols = reshape(PAMSymbols, 1, []);

validateattributes(M, {'numeric'}, {'scalar', 'integer', '>=', 4}, mfilename, 'M');
bitsPerSymbol = log2(M);
if bitsPerSymbol ~= round(bitsPerSymbol) || sqrt(M) ~= round(sqrt(M))
    error('DICO:OFDM:UnsupportedQAM', ...
        'M must be a power-of-two square-QAM order such as 4, 16, or 64.');
end

symbolIndices = qamdemod(PAMSymbols, M, 'gray', 'UnitAveragePower', true);
% The explicit width is essential: without it, de2bi may omit leading zeros
% when the current block does not contain the largest constellation index.
bitMatrix = de2bi(symbolIndices, bitsPerSymbol, 'left-msb');
bitvector = reshape(bitMatrix.', 1, []);
end

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
