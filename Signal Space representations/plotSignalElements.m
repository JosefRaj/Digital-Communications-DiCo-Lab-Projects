% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: plotSignalElements.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

function plotSignalElements(ovs)
%PLOTSIGNALELEMENTS Display all four elements for CDM, FDM, and TDM.

if nargin < 1
    ovs = 64;
end
validateattributes(ovs, {'numeric'}, {'scalar','integer','>=',4});
if mod(ovs,4) ~= 0
    error('plotSignalElements:InvalidOvs', 'ovs must be a multiple of four.');
end

types = {'CDM','FDM','TDM'};
t = (0:ovs-1)/ovs;
for typeIndex = 1:numel(types)
    type = types{typeIndex};
    signalElements = generateSignalElements(type, ovs);
    figure('Name', [type ' signal elements']);
    tiledlayout(4,1, 'TileSpacing','compact');
    for m = 1:4
        nexttile;
        plot(t, real(signalElements(m,:)), 'LineWidth', 1.1);
        hold on;
        if ~isreal(signalElements(m,:))
            plot(t, imag(signalElements(m,:)), '--', 'LineWidth', 1.1);
            legend('Real part','Imaginary part', 'Location','best');
        end
        grid on;
        ylabel(sprintf('s_%d',m-1));
        if m == 1
            title([type ' signal elements']);
        end
        if m == 4
            xlabel('t/T');
        end
    end
end
end

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
