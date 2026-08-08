% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: analyzeSISOChannelGain.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% SISO channel-gain distribution - Lab Exercise L-5.4
rng(1);
N = 2e5;
%numRealizations = 2e5;


% TODO L-5.4:
% 1. Generate scalar h ~ CN(0,1).
% 2. Plot a PDF-normalized histogram of |h|.
% 3. Overlay the analytical Rayleigh density for sigma = 1/sqrt(2).
% 4. Compare empirical and analytical moments.


% Number of channel realizations
%N = 1e6;

% Generate Rayleigh fading coefficients
h = (randn(1,N) + 1i*randn(1,N))/sqrt(2);

% Channel gain
gain = abs(h);

empiricalmean =  mean(gain);
empiricalVariance = var (gain);

sigma = 1/sqrt(2);

theoreticalMean = sigma * sqrt(pi/2);
theoreticalVariance = ((4-pi)/2) * sigma^2;

% Histogram (normalized to PDF)
figure;
histogram(gain, 100,'Normalization','pdf');
hold on;

% Theoretical Rayleigh PDF
r = linspace(0,max(gain),500);
pdfTheory = 2*r.*exp(-r.^2);
plot(r,pdfTheory,'r','LineWidth',2);
grid on;
xlabel('|h|');
ylabel('Probability Density');
title('SISO Channel Gain PDF');
legend('Simulation','Theory');

disp(empiricalmean);
disp(empiricalVariance);
disp(theoreticalMean);
disp(theoreticalVariance);

%error('analyzeSISOChannelGain:NotImplemented', ...
 %   'Complete Lab Exercise L-5.4 in analyzeSISOChannelGain.m.');

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
