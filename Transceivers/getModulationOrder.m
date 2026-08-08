% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Utility function: getModulationOrder.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: Infrastructure file - do not edit
%
% Returns the constellation size and the number of bits per symbol.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function [M, bitsPerSymbol] = getModulationOrder(PAM_type)
%GETMODULATIONORDER Return M and log2(M) for a supported modulation type.

PAM_type = validatestring(PAM_type, {'BPSK', '4QAM', '8ASKbipolar'});

switch PAM_type
    case 'BPSK'
        M = 2;
    case '4QAM'
        M = 4;
    case '8ASKbipolar'
        M = 8;
end

bitsPerSymbol = log2(M);
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
