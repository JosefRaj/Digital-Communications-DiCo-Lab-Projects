% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: simulateSIMO_MRC.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% SIMO maximum-ratio combining - Lab Exercise L-5.5
rng(1);

L = 1e3;
numChannels = 1e3;
M = 4;
nr = 2;
nt = 1;
SNRdB = -10:5:50;
SER = zeros(size(SNRdB));
sigma_x_2 = qamSymbolVariance(M);

if ~exist('M','var')
    M = 4;
end

if ~exist('nr','var')
    nr = 2;
end

for channelIndex = 1:numChannels
    h = (randn(nr,nt) + 1i*randn(nr,nt)) / sqrt(2);
    x = GetQAM(nt, L, M);

    for snrIndex = 1:numel(SNRdB)
        sigma_n_2 = sigma_x_2 / 10^(SNRdB(snrIndex)/10);
        noise = sqrt(sigma_n_2/2) * ...
            (randn(nr,L) + 1i*randn(nr,L));
        y = h*x + noise;

        % TODO L-5.5:
        % Apply MRC and normalize the result to the original QAM scale.
        % Then quantize and accumulate symbol errors.
        % Maximum Ratio Combining (MRC)
        x_hat = (h' * y) / sum(abs(h).^2);

        x_detected = QuantQAM(x_hat,M);

        SER(snrIndex) = SER(snrIndex) + sum(x_detected(:) ~= x(:));

        %error('simulateSIMO_MRC:NotImplemented', ...
           % 'Complete Lab Exercise L-5.5 in simulateSIMO_MRC.m.');
    end
end

% TODO: Normalize error counts and plot the result together with SISO.
SER = SER/(L*numChannels);

figure;
semilogy(SNRdB,SER,'o-','LineWidth',2);
grid on;
grid minor;
xlabel('SNR (dB)');
ylabel('SER');
title('SIMO (2x1) with Maximum Ratio Combining');

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
