% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: simulateMIMO_ZF.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% MIMO zero-forcing linear equalization - Lab Exercise L-5.9
rng(1);

L = 250;
numChannels = 1e3;
M = 4;
nt = 4;
nr = 4;
SNRdB = -10:5:50;
SER = zeros(size(SNRdB));
sigma_x_2 = qamSymbolVariance(M);

assert(nr >= nt, 'ZF requires nr >= nt for this lab setup.');

for channelIndex = 1:numChannels
    H = (randn(nr,nt) + 1i*randn(nr,nt)) / sqrt(2);
    x = GetQAM(nt, L, M);

    for snrIndex = 1:numel(SNRdB)
        sigma_n_2 = sigma_x_2 / 10^(SNRdB(snrIndex)/10);
        noise = sqrt(sigma_n_2/2) * ...
            (randn(nr,L) + 1i*randn(nr,L));
        y = H*x + noise;

        % TODO L-5.9:
        % Apply ZF without explicitly calculating inv(H), quantize all
        % streams, and accumulate the total number of symbol errors.

         % ZF equalizer (preferred over inv(H))
        z = inv(H) * y;

        % Detect all transmitted symbols
        x_detected = QuantQAM(z, M);

        % Count symbol errors
        SER(snrIndex) = SER(snrIndex) + sum(x_detected(:) ~= x(:));

       % error('simulateMIMO_ZF:NotImplemented', ...
           % 'Complete Lab Exercise L-5.9 in simulateMIMO_ZF.m.');
    end
end

% TODO: Normalize by nt*L*numChannels and plot the SER.

SER = SER / (nt * L * numChannels);

figure;
semilogy(SNRdB, SER, 'o-', 'LineWidth', 2);
grid on;
grid minor;

xlabel('SNR (dB)');
ylabel('SER');

title('4×4 MIMO using Zero-Forcing Equalization');
legend('ZF','Location','southwest');

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
