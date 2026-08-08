% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: simulateMIMO_MMSE.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% MIMO MMSE linear equalization - Lab Exercise L-5.10
rng(1);

L = 250;
numChannels = 1e3;
M = 4;
nt = 4;
nr = 4;
SNRdB = -10:5:100;
SER_ZF = zeros(size(SNRdB));
SER_MMSE = zeros(size(SNRdB));
sigma_x_2 = qamSymbolVariance(M);

for channelIndex = 1:numChannels
    H = (randn(nr,nt) + 1i*randn(nr,nt)) / sqrt(2);
    x = GetQAM(nt, L, M);

    for snrIndex = 1:numel(SNRdB)
        sigma_n_2 = sigma_x_2 / 10^(SNRdB(snrIndex)/10);
        noise = sqrt(sigma_n_2/2) * ...
            (randn(nr,L) + 1i*randn(nr,L));
        y = H*x + noise;

        % TODO L-5.10:
        % Calculate both ZF and MMSE estimates for the same H, x, and noise.
        % Do not form explicit matrix inverses. Quantize and accumulate.

        z_ZF = H \ y;

        xHat_ZF = QuantQAM(z_ZF, M);

        SER_ZF(snrIndex) = SER_ZF(snrIndex) + sum(xHat_ZF(:) ~= x(:));


        I = eye(nt);

        W_MMSE = (H' * H + (sigma_n_2/sigma_x_2) * I) \ H';

        z_MMSE = W_MMSE * y;

        xHat_MMSE = QuantQAM(z_MMSE, M);

        SER_MMSE(snrIndex) = SER_MMSE(snrIndex) + sum(xHat_MMSE(:) ~= x(:));

       % error('simulateMIMO_MMSE:NotImplemented', ...
            %'Complete Lab Exercise L-5.10 in simulateMIMO_MMSE.m.');
    end
end

% TODO: Normalize and plot both curves in the same figure.

SER_ZF = SER_ZF / (nt * L * numChannels);

SER_MMSE = SER_MMSE / (nt * L * numChannels);



figure;

semilogy(SNRdB, SER_ZF, 'o-', 'LineWidth', 2);
hold on;

semilogy(SNRdB, SER_MMSE, 's-', 'LineWidth', 2);

grid on;
grid minor;

xlabel('SNR (dB)');
ylabel('SER');

title('4×4 MIMO: ZF vs MMSE');

legend('ZF','MMSE','Location','southwest');

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
