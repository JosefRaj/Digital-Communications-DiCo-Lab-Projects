% =========================================================================
% DICO LAB COURSE | PROJECT 2 | SUMMER 2026
% Project 3 placeholder: dispersive_channel.m
% FILE-SET ID: DICO-LAB2-S26-v1.0
% Release date: 2026-07-30
% Related exercise: Not used in Project 2
%
% Identity channel for Project 2. It is replaced/activated in Project 3.
%
% This file belongs to the official Summer 2026 distribution.
% Older files without the FILE-SET ID above should not be used.
% =========================================================================
function channelOutput = dispersive_channel(channelInput)
%DISPERSIVE_CHANNEL Project 3 placeholder; identity operation in Project 2.

channelInput = channelInput(:).';
validateattributes(channelInput, {'numeric'}, {'vector', 'nonempty', 'finite'});
channelOutput = channelInput;
end

% =========================================================================
% END OF FILE | DICO-LAB2-S26-v1.0 | SUMMER 2026
% =========================================================================
