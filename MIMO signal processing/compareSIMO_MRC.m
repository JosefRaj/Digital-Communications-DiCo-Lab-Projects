% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: compareSIMO_MRC.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% MRC parameter study - Lab Exercise L-5.6
rng(1);

SNRdB = -10:5:50;
nrValues = [2 4 8];
MValues = [4 16];
L = 500;
numChannels = 1e3;

% TODO L-5.6:
% Run the normalized MRC simulation for all combinations of nrValues and
% MValues. Plot the SER curves in one figure and discuss diversity and the
% effect of a larger constellation.


figure;
hold on;

markers = {'o-','s-','d-','^-','v-','*-'};
count = 1;

for mIndex = 1:length(MValues)
    M = MValues(mIndex);
    for nrIndex = 1:length(nrValues)
        nr = nrValues(nrIndex);
        SER = zeros(size(SNRdB));
        sigma_x_2 = qamSymbolVariance(M);
        for channelIndex = 1:numChannels
            h = (randn(nr,1)+1i*randn(nr,1))/sqrt(2);
            x = GetQAM(1,L,M);
            for snrIndex = 1:length(SNRdB)
                sigma_n_2 = sigma_x_2/10^(SNRdB(snrIndex)/10);
                noise = sqrt(sigma_n_2/2)*(randn(nr,L)+1i*randn(nr,L));
                y = h*x + noise;

                x_hat = (h'*y)/(h'*h);

                x_detected = QuantQAM(x_hat,M);

                SER(snrIndex)=SER(snrIndex)+sum(x_detected(:)~=x(:));

            end

        end

        SER = SER/(L*numChannels);

        semilogy(SNRdB,SER,markers{count},'LineWidth',2);

        hold on;

        count = count + 1;

    end

end

grid on;
grid minor;

xlabel('SNR (dB)');
ylabel('SER');

set(gca,'YScale','log');
ylim([1e-5 1]);

title('SIMO MRC Performance');

legend('4-QAM NR=2', '4-QAM NR=4','4-QAM NR=8',...
    '16-QAM NR=2','16-QAM NR=4','16-QAM NR=8',...
    'Location','southwest');


%error('compareSIMO_MRC:NotImplemented', ...
%    'Complete Lab Exercise L-5.6 in compareSIMO_MRC.m.');

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
