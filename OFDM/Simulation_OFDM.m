% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: Simulation_OFDM.m
% Purpose: Main student simulation and BER framework.
% =========================================================================
%% DICO Lab Course - Project 4 - OFDM
clearvars;
close all;
clc;

%% Do not change the initialization of the randomness without permission.
rng(1);
fprintf('DICO Project 4 starter package: DICO-LAB4-S26-v1.0\n');

%% Loop parameters
%EbN0_dB_Vector = -10:2:20;
%BER_Vector = nan(size(EbN0_dB_Vector));

EbN0_dB_Vector = -10:2:30; 
profiles = {'identity','profile1','profile2','profile3'}; 
BER = zeros(length(profiles),length(EbN0_dB_Vector));

%% Simulation parameters
M = 4;                         % square-QAM order: 4, 16, ...
%channelProfile = 'profile1';   % profile1, profile2, profile3, identity
numberOfBits = 12e5;
channelProfile = profiles{1};

% [D, ~, channelProfile] = ofdm_parameters(channelProfile);
% bitsPerSymbol = log2(M);
% if bitsPerSymbol ~= round(bitsPerSymbol) || sqrt(M) ~= round(sqrt(M))
%     error('DICO:OFDM:UnsupportedQAM', ...
%         'M must be a power-of-two square-QAM order.');
% end
% bitsPerOFDMBlock = D * bitsPerSymbol;
% 
% %% Create source bits and pad once to a complete OFDM block
% sourceBits = randi([0 1], 1, numberOfBits);
% numberOfPaddingBits = mod(-numel(sourceBits), bitsPerOFDMBlock);
% traBits = [sourceBits, zeros(1, numberOfPaddingBits)];
% 
% %% Transmitter - independent of Eb/N0
% traSignal = ofdm_transmitter(traBits, M);
% %analyze_signal(traSignal);
% 
% % TODO(L-4.6): For the dedicated 1,200,000-bit analysis run, call
% %analyze_signal(traSignal); %Keep this disabled during BER sweeps.
% 
% %% Dispersive channel - independent of Eb/N0
% channelSignal = dispersive_channel(traSignal, channelProfile);
% %analyze_signal(channelSignal);
% %channelSignal = dispersive_channel(traSignal, 'profile1');
% 
% % TODO(L-4.7): Analyze channelSignal or one noisy recSignal and compare it
% % with traSignal in time and frequency domain.

%% Eb/N0 loop
% for index = 1:numel(EbN0_dB_Vector)
%     EbN0_dB = EbN0_dB_Vector(index);
% 
%     % AWGN is referenced to the OFDM signal before the dispersive channel.
%     recSignal = ofdm_awgn_channel(channelSignal, traSignal, ...
%         EbN0_dB, numel(traBits));
% 
%     recBitsPadded = ofdm_receiver(recSignal, M, channelProfile);
%     if numel(recBitsPadded) < numel(sourceBits)
%         error('DICO:OFDM:ReceiverTooShort', ...
%             'The receiver returned fewer bits than were transmitted.');
%     end
%     recBits = recBitsPadded(1:numel(sourceBits));
%     BER_Vector(index) = calculateBER_ofdm(sourceBits, recBits);
% end

for p = 1:length(profiles)

    channelProfile = profiles{p};

    [D,~,channelProfile] = ofdm_parameters(channelProfile);

    bitsPerSymbol = log2(M);
    bitsPerOFDMBlock = D*bitsPerSymbol;

    sourceBits = randi([0 1],1,numberOfBits);
    numberOfPaddingBits = mod(-numel(sourceBits),bitsPerOFDMBlock);

    traBits = [sourceBits zeros(1,numberOfPaddingBits)];

    traSignal = ofdm_transmitter(traBits,M);

    channelSignal = dispersive_channel(traSignal,channelProfile);

    for index = 1:length(EbN0_dB_Vector)

        EbN0_dB = EbN0_dB_Vector(index);

        recSignal = ofdm_awgn_channel(channelSignal,traSignal,EbN0_dB,numel(traBits));

        recBitsPadded = ofdm_receiver(recSignal,M,channelProfile);

        recBits = recBitsPadded(1:numel(sourceBits));

        BER(p,index)=calculateBER_ofdm(sourceBits,recBits);

    end

end



%% BER plot
% figure;
% %semilogy(EbN0_dB_Vector, max(BER_Vector,0.8/numberOfBits), 'o-');
% semilogy(EbN0_dB_Vector,BER_Vector, 'o-');
% grid on;
% xlabel('E_b/N_0 (dB)');
% ylabel('Bit error ratio');
% set(gca, 'Yscale','log')
% ylim([1e-5,1])
% title(sprintf('%d-QAM OFDM, %s', M, channelProfile));
% legend(channelProfile, 'Location', 'southwest');

figure; hold on;

styles = {'o-','s-','d-','^-'};

for p = 1:length(profiles)
semilogy(EbN0_dB_Vector,BER(p,:),styles{p},'LineWidth',2,'MarkerSize',7);
end

grid on; grid minor; 
xlabel('E_b/N_0 (dB)'); 
ylabel('Bit error ratio');
%title(sprintf('%d-QAM OFDM’,M));
legend(profiles,'Location','southwest'); 
ylim([1e-3 1]);

% TODO(L-4.12): Repeat the run for all channel profiles and compare the
% curves. Do not infer a reliable BER from points with only a few errors.

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
