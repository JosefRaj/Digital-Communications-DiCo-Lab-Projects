% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: analyzeSIMOGain.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% Effective SIMO channel gain - Lab Exercise L-5.7
rng(1);
N = 2e5;
%numRealizations = 2e5;

%nrValues = [1 2 4 8];

% TODO L-5.7:
% For each nr, generate h ~ CN(0,I), calculate G = ||h||^2, and compare
% its PDF-normalized histogram with the Gamma(shape=nr, scale=1) density.
% Verify mean(G)=nr and var(G)=nr.
% Number of channel realizations

%N = 1e6;

% Number of receive antennas
nr = 2;

% Generate Rayleigh channel
h = (randn(nr,N) + 1i*randn(nr,N))/sqrt(2);

% Effective channel gain after MRC
gainSIMO = sum(abs(h).^2,1);

% SISO gain for comparison
hSISO = (randn(1,N) + 1i*randn(1,N))/sqrt(2);
gainSISO = abs(hSISO).^2;

% Histogram of SIMO gain
figure;

histogram(gainSIMO, 100,'Normalization','pdf');

hold on;

% Histogram of SISO gain
histogram(gainSISO, 100,'Normalization','pdf');

% Analytical PDF (Gamma distribution for NR = 2)
x = linspace(0,max(gainSIMO),500);

pdfTheory = x .* exp(-x);

plot(x,pdfTheory,'r','LineWidth',2);

grid on;

xlabel('Channel Gain');

ylabel('Probability Density');

title('SIMO Effective Channel Gain');

legend('SIMO (Histogram)','SISO (Histogram)','Theory gainSIMO');

% hold on;
% 
% r = linspace(0,max(gain),500);
% pdfTheory = 2*r.*exp(-r.^2);
% plot(r,pdfTheory,'e','LineWidth',2);
% grid on;
% xlabel('|h|');
% ylabel('Probability Density');
% title('SISO Channel Gain PDF');
% legend('Simulation','Theory');


%error('analyzeSIMOGain:NotImplemented', ...
 %   'Complete Lab Exercise L-5.7 in analyzeSIMOGain.m.');

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
