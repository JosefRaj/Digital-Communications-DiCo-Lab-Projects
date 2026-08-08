% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: generateFSKSignalElements.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function signalElements = generateFSKSignalElements(M, h, ovs, phase0)
%GENERATEFSKSIGNALELEMENTS Generate complex M-ary FSK signal elements.
% The symbol indices are i=0,...,M-1 and n=0,...,ovs-1.

narginchk(3,4);
if nargin < 4
    phase0 = 0;
end
validateattributes(M, {'numeric'}, {'scalar','integer','>=',2});
validateattributes(h, {'numeric'}, {'scalar','real'});
validateattributes(ovs, {'numeric'}, {'scalar','integer','>=',M});
validateattributes(phase0, {'numeric'}, {'scalar','real'});

% TODO L-4.10:
% Implement s_i[n] = exp(1j*(2*pi*i*h*n/ovs + phase0)).

signalElements = zeros(M, ovs);

n = 0:ovs-1;

for i = 0:M-1
    signalElements(i+1,:) = exp(1j*(2*pi*i*h*n/ovs + phase0));
end


%error('generateFSKSignalElements:NotImplemented', ...
 %   'Complete Lab Exercise L-4.10 in generateFSKSignalElements.m.');
end

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
