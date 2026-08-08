% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: feq.m
% Purpose: Provided one-tap frequency-domain equalizer.
% =========================================================================
function PAMSymbolsEq = feq(PAMSymbols, channelProfile)
%FEQ One-tap frequency-domain equalization for every OFDM subchannel.

if nargin < 2
    channelProfile = 'profile1';
end
validateattributes(PAMSymbols, {'numeric'}, {'2d', 'nonempty'}, ...
    mfilename, 'PAMSymbols');
[D, h] = ofdm_parameters(channelProfile);
if size(PAMSymbols, 2) ~= D
    error('DICO:OFDM:WrongSubchannelCount', ...
        'PAMSymbols must have exactly D = %d columns.', D);
end

H = fft(h, D);
if any(abs(H) < 1e-10)
    error('DICO:OFDM:SingularFEQ', ...
        'At least one channel coefficient is too close to zero for ZF FEQ.');
end

% Implicit expansion applies the same D coefficients to every OFDM block.
PAMSymbolsEq = PAMSymbols ./ H;
end

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
