% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: simulateSISO.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% SISO flat-fading simulation - Lab Exercise L-5.3
rng(1);  % Do not change without permission.

%% Parameters
L = 1e3;                 % symbols per channel realization
numChannels = 1e3;       % independent fading realizations
M = 4;                   % square QAM order
nr = 1;
nt = 1;
SNRdB = -10:5:50;
SER = zeros(size(SNRdB));

sigma_x_2 = qamSymbolVariance(M);

%% Monte-Carlo simulation
for channelIndex = 1:numChannels
    H = (randn(nr,nt) + 1i*randn(nr,nt)) / sqrt(2);
    x = GetQAM(nt, L, M);

    for snrIndex = 1:numel(SNRdB)
        sigma_n_2 = sigma_x_2 / 10^(SNRdB(snrIndex)/10);
        noise = sqrt(sigma_n_2/2) * (randn(nr,L) + 1i*randn(nr,L));

        % TODO L-5.3:
        % 1. Form the receive signal y = H*x + noise.
        % 2. Equalize the scalar fading coefficient.
        % 3. Quantize and accumulate the number of symbol errors.
         % Step 1: Receive signal
        y = H*x + noise;

        % Step 2: Equalize the channel
        x_hat = y ./ H;

        % Step 3: Quantize received symbols
        x_detected = QuantQAM(x_hat,M);

        % Step 4: Count symbol errors
        SER(snrIndex) = SER(snrIndex) + sum(x_detected(:) ~= x(:));

        %error('simulateSISO:NotImplemented', ...
            %'Complete Lab Exercise L-5.3 in simulateSISO.m.');
    end
end

% TODO: Normalize the accumulated error counts to obtain the SER.

% Normalize error count
SER = SER/(L*numChannels);

semilogy(SNRdB, SER, 'o-');
grid on;
xlabel('SNR (dB)');
ylabel('SER');
title('SISO over Rayleigh flat fading');
hold on

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
