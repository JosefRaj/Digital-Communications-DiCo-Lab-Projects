% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: dispersive_channel.m
% Purpose: Provided frequency-selective FIR channel.
% =========================================================================
function channelOutput = dispersive_channel(channelInput, channelProfile)
%DISPERSIVE_CHANNEL Apply the selected causal FIR channel.

if nargin < 2
    channelProfile = 'profile1';
end
validateattributes(channelInput, {'numeric'}, {'vector', 'nonempty'}, ...
    mfilename, 'channelInput');
[~, h] = ofdm_parameters(channelProfile);

wasColumn = iscolumn(channelInput);
channelInput = reshape(channelInput, 1, []);
channelOutput = filter(h, 1, channelInput);
if wasColumn
    channelOutput = channelOutput.';
end
end

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
