% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: transmitter_SE.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function transmitSignal = transmitter_SE(bitstream, type, ovs)
%TRANSMITTER_SE Map two-bit words and concatenate their signal elements.

narginchk(3,3);
bitstream = bitstream(:).';
if any((bitstream ~= 0) & (bitstream ~= 1))
    error('transmitter_SE:NonBinaryInput', ...
        'bitstream must contain only zeros and ones.');
end
if mod(numel(bitstream),2) ~= 0
    error('transmitter_SE:OddBitCount', ...
        'The bitstream length must be even because M=4.');
end

% TODO L-4.2:
% 1. Call generateSignalElements(type, ovs).
% 2. Convert every two-bit word (left-most bit is the MSB) to a signal number.
% 3. Select and concatenate the corresponding rows.
signalElements = generateSignalElements(type, ovs);

transmitSignal = [];

for k = 1:2:length(bitstream)
    twoBits = bitstream(k:k+1);
    signalNo = bi2de(twoBits,'left-msb');
    signalNo = signalNo + 1;
    selectedSignal = signalElements(signalNo,:);
    transmitSignal = [transmitSignal selectedSignal];

end

%error('transmitter_SE:NotImplemented', ...
   % 'Complete Lab Exercise L-4.2 in transmitter_SE.m.');
end

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
