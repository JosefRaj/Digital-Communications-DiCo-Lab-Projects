% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: verify_given_transmit_signal.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% Verify the signal from Fig. 4.3 / Lab Exercise L-4.3
ovs = 64;

% TODO L-4.3: Insert the bit sequence obtained in Homework H-4.2.
bitstream = [0 0 0 1 1 0 1 1 0 1 0 1 0 0 1 0 1 0 1 1];


if isempty(bitstream)
    error('Insert the bit sequence from Homework H-4.2 first.');
end
transmitSignal = transmitter_SE(bitstream, 'CDM', ovs);
t = (0:numel(transmitSignal)-1)/ovs;
figure;
plot(t, real(transmitSignal), 'LineWidth',1.1);
grid on;
xlabel('t/T');
ylabel('s(t)');
title('Transmit signal for Lab Exercise L-4.3');

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
