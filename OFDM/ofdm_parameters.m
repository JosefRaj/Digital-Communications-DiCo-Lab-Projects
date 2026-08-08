% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: ofdm_parameters.m
% Purpose: Common D and channel-profile configuration.
% =========================================================================
function [D, h, channelProfile] = ofdm_parameters(channelProfile)
%OFDM_PARAMETERS Return the common OFDM size and selected channel response.
%
%   [D, h, channelProfile] = ofdm_parameters(channelProfile)
%
% The channel profiles reproduce the coefficient sets distributed in older
% versions. Keeping them in one function prevents dispersive_channel.m and
% feq.m from silently using different coefficients.

if nargin < 1 || isempty(channelProfile)
    channelProfile = 'profile1';
end

if isstring(channelProfile)
    channelProfile = char(channelProfile);
end
validateattributes(channelProfile, {'char'}, {'row'}, mfilename, 'channelProfile');

D = 8;

switch lower(strtrim(channelProfile))
    case {'profile1', 'mild'}
        channelProfile = 'profile1';
        h = [0.85 -0.30 0.25 -0.16 0.29 0.03];
    case {'profile2', 'strong'}
        channelProfile = 'profile2';
        h = [3 -0.5 2 -0.9 -0.008 0.002];
    case {'profile3', 'attenuating'}
        channelProfile = 'profile3';
        h = [0.1940 0.0531 0.0489 0.0135 0.0198 0.0318];
    case {'identity', 'none'}
        channelProfile = 'identity';
        h = 1;
    otherwise
        error('DICO:OFDM:UnknownChannelProfile', ...
            ['Unknown channel profile "%s". Use profile1, profile2, ' ...
             'profile3, or identity.'], channelProfile);
end

h = reshape(h, 1, []);
if numel(h) > D
    error('DICO:OFDM:ChannelTooLong', ...
        'The channel impulse response must not exceed D = %d samples.', D);
end
end

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
