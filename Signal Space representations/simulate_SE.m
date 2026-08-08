% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: simulate_SE.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% DICO Project 4 - Signal-space transmission over AWGN
% Do not change the initialization of the randomness without permission.
rng(1,'twister');

%% Simulation parameters
EbN0_dB_Vector = -6:1:12;
numberOfBits = 1e5;       % must be even because each symbol carries two bits
ovs = 16;                 % samples per signal element; multiple of four
%type = 'FDM';             % choose 'CDM', 'FDM', or 'TDM'

assert(mod(numberOfBits,2) == 0, 'numberOfBits must be even.');
assert(mod(ovs,4) == 0, 'ovs must be a multiple of four.');

types = {'CDM','FDM','TDM'};
%% Source and transmitter
%figure;
%hold on;
grid on;

for t = 1:length(types)

    type = types{t};

    % Generate random bits
    traBits = randi([0 1],1,numberOfBits);

    % Transmitter
    traSignal = transmitter_SE(traBits,type,ovs);
    BER_Vector = zeros(size(EbN0_dB_Vector));
    
for snrIndex = 1:length(EbN0_dB_Vector)
        EbN0_dB = EbN0_dB_Vector(snrIndex);
        recSignal = se_awgn_channel(traSignal,EbN0_dB,numberOfBits);
        recBits = receiver_SE(recSignal,type,ovs);
        BER_Vector(snrIndex) = calculateBER(traBits,recBits);
 end

    semilogy(EbN0_dB_Vector,max(BER_Vector,0.8/numberOfBits),'DisplayName',type);
    hold on;
end 
   
xlabel('E_b/N_0 (dB)');
ylabel('BER');
title('BER Comparison');
legend;
grid on;


% TODO L-4.5:
% Extend this script to run CDM, FDM, and TDM and show all three curves in
% the same figure. A measured BER of zero means only that no error occurred
% in this finite record; it is not a mathematical BER of zero.

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
