% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: generateSignalElements.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function signalElements = generateSignalElements(type, ovs)

%GENERATESIGNALELEMENTS Generate four signal elements for CDM, FDM, or TDM.
%
% Input:
%   type - 'CDM', 'FDM', or 'TDM'
%   ovs  - number of samples per signal element; multiple of four
%
% Output:
%   signalElements - 4-by-ovs matrix; one signal element per row

narginchk(2,2);
if ~(ischar(type) || (isstring(type) && isscalar(type)))
    error('generateSignalElements:InvalidType', 'type must be a text scalar.');
end
type = upper(strtrim(char(type)));
validateattributes(ovs, {'numeric'}, {'scalar','integer','>=',4});
if mod(ovs,4) ~= 0
    error('generateSignalElements:InvalidOvs', ...
        'ovs must be a multiple of four.');
end
if ~ismember(type, {'CDM','FDM','TDM'})
    error('generateSignalElements:UnknownType', ...
        'Unknown type "%s". Use CDM, FDM, or TDM.', type);
end

% TODO L-4.1:
% 1. Allocate a 4-by-ovs matrix.
% 2. Generate the four rows according to Fig. 4.2 of the lab script.
% 3. For FDM, use a discrete time vector n = 0:(ovs-1).

signalElements = zeros(4,ovs);

switch type

    case 'CDM'
        signalElements(1,:) = ones(1,ovs);
        signalElements(2,:) = -ones(1,ovs);
        signalElements(3,:) = [-ones(1,ovs/2) ones(1,ovs/2)];
        signalElements(4,:) = [ones(1,ovs/2) -ones(1,ovs/2)];
     case 'TDM'
        L = ovs/4;
        signalElements(1,1:L) = 1;
        signalElements(2,L+1:2*L) = 1;
        signalElements(3,2*L+1:3*L) = 1;
        signalElements(4,3*L+1:4*L) = 1;
    case 'FDM'
        n = 0:ovs-1;
        signalElements(1,:) = exp(1j*2*pi*0*n/ovs);
        signalElements(2,:) = exp(1j*2*pi*1*n/ovs);
        signalElements(3,:) = exp(1j*2*pi*2*n/ovs);
        signalElements(4,:) = exp(1j*2*pi*3*n/ovs);

%error('generateSignalElements:NotImplemented', ...
 %   'Complete Lab Exercise L-4.1 in generateSignalElements.m.');
end

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
