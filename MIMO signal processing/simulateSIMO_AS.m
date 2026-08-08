% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: simulateSIMO_AS.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% SIMO antenna selection - Lab Exercise L-5.8
rng(1);

L = 1e3;
numChannels = 1e3;
M = 4;
nr = 2;
nt = 1;
SNRdB = -10:5:50;
SER = zeros(size(SNRdB));
sigma_x_2 = qamSymbolVariance(M);

for channelIndex = 1:numChannels
    h = (randn(nr,nt) + 1i*randn(nr,nt)) / sqrt(2);
    x = GetQAM(nt, L, M);

    % TODO L-5.8: Select the branch with the largest instantaneous SNR.
    [~,idx] = max(abs(h));

    for snrIndex = 1:numel(SNRdB)
        sigma_n_2 = sigma_x_2 / 10^(SNRdB(snrIndex)/10);
        noise = sqrt(sigma_n_2/2) * (randn(nr,L) + 1i*randn(nr,L));
        y = h*x + noise;

        % TODO: Equalize only the selected branch, quantize, and accumulate.
        % Select the received signal from the best antenna
        y_best = y(idx,:);

        x_hat = y_best / h(idx);

        % Quantize detected symbols
        x_detected = QuantQAM(x_hat,M);

        % Count symbol errors
        SER(snrIndex) = SER(snrIndex) + sum(x_detected(:) ~= x(:));


        %error('simulateSIMO_AS:NotImplemented', ...
            %'Complete Lab Exercise L-5.8 in simulateSIMO_AS.m.');
    end
end

% TODO: Normalize and compare with SISO and MRC.

SER = SER/(L*numChannels);
semilogy(SNRdB,SER,'o-','LineWidth',2);
grid on;
xlabel('SNR (dB)');
ylabel('SER');
title('SIMO (2x1) using Antenna Selection');
legend('AS','Location','southwest');
% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
