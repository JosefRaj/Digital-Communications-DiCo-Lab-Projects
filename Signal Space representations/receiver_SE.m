% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: receiver_SE.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function dec_bits = receiver_SE(receivedSignal, type, ovs)
%RECEIVER_SE Coherent correlation receiver for four signal elements.

narginchk(3,3);
receivedSignal = receivedSignal(:).';
validateattributes(ovs, {'numeric'}, {'scalar','integer','>=',4});
if mod(numel(receivedSignal),ovs) ~= 0
    error('receiver_SE:LengthMismatch', ...
        'The receive-vector length must be a multiple of ovs.');
end

% TODO L-4.4:
% 1. Generate the four signal elements.
% 2. Split receivedSignal into blocks of ovs samples.
% 3. Correlate every block with every possible signal element.
% 4. Apply the coherent ML decision metric and select its maximum.
% 5. Convert each detected signal number to two bits (left MSB first).
%ignalElements = generateSignalElements(type, ovs);

signalElements = generateSignalElements(type, ovs);

dec_bits = [];

for k = 1:ovs:length(receivedSignal)

    r = receivedSignal(k:k+ovs-1);

    metric = zeros(1,4);

    for m = 1:4

        s = signalElements(m,:);

        metric(m) = real(sum(conj(s).*r)) - 0.5*sum(abs(s).^2);
    end

    [~,index] = max(metric);

    signalNumber = index - 1;

    if signalNumber == 0
        bits = [0 0];

    elseif signalNumber == 1
        bits = [0 1];

    elseif signalNumber == 2
        bits = [1 0];

    else
        bits = [1 1];

    end
    dec_bits = [dec_bits bits];

end



% Hint: for unequal signal energies, the metric is
%   real(<r,s_m>) - 0.5*sum(abs(s_m).^2).

%error('receiver_SE:NotImplemented', ...
 %   'Complete Lab Exercise L-4.4 in receiver_SE.m.');
end

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
