% ========================================================================
% DICO LAB COURSE - PROJECT 4: SIGNAL SPACE REPRESENTATION
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB4-SS-S26-v1.0
% File: explore_orthogonalization_and_fsk.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% Extension tasks L-4.7 to L-4.11
%ovs = 64;

%% L-4.7: compare the homework signal elements with Gram-Schmidt
% Build the three row vectors from Homework H-4.4 and call gramSchmidtSE.
%L = ovs/4;

% -------------------------------------------------------
% Signal elements from Homework H-3.4 (Figure 3.5)
% -------------------------------------------------------

ovs = 64;  
L = ovs/4;  
  
A = sqrt(1);     % Normalized amplitude  
  
s0 = [ A*ones(1,4*L)];  
  
s1 = [-A*ones(1,2*L) A*ones(1,L) -A*ones(1,L)];  
  
s2 = [2*A*ones(1,2*L) zeros(1,L) 2*A*ones(1,L)];  
  
signalElements = [  
    s0;  
    s1;  
    s2  
];  
  
[basisFunctions,coefficients,selectionOrder] = ...  
    gramSchmidtSE(signalElements,'incremental');  
  
disp(basisFunctions)  
disp(coefficients)  
disp(selectionOrder)  

figure;

for k = 1:size(basisFunctions,1)
    subplot(size(basisFunctions,1),1,k);
    plot(basisFunctions(k,:),'LineWidth',2);
    grid on;
    xlabel('Sample');
    ylabel(['g' num2str(k-1)]);
    title(['Basis Function g' num2str(k-1)]);
end

%plot(s0)
%plot(s1)
%plot(s2)
%plot(basisFunctions(1,:))

%% L-4.8 and L-4.9: CDM basis and reconstruction
% cdmElements = generateSignalElements('CDM', ovs);
% [G_CDM, C_CDM] = gramSchmidtSE(cdmElements, 'incremental');
% reconstructedCDM = C_CDM.' * G_CDM;

cdmElements = generateSignalElements('CDM', ovs);

[G_CDM, C_CDM, selectionOrder] = gramSchmidtSE(cdmElements,'incremental');

reconstructedCDM = C_CDM.' * G_CDM;

%figure;
%hold on
disp('Original CDM Signal Elements');
disp(cdmElements);
%plot(cdmElements(0));

disp('Reconstructed Signal Elements');
disp(reconstructedCDM);

figure;
%plot(real(cdmElements(3 ,: )))

for k = 1:size(cdmElements,1)

    subplot(4,2,2*k-1);

    plot(real(cdmElements(k,:)),'LineWidth',2);
    grid on;
    title(['Original s_' num2str(k-1)]);

    subplot(4,2,2*k);

    plot(real(reconstructedCDM(k,:)),'LineWidth',2);
    grid on;
    title(['Reconstructed s_' num2str(k-1)]);

end



%% L-4.10 and L-4.11: FSK with M=4 and h=1/4
% fskElements = generateFSKSignalElements(4, 1/4, ovs, 0);
% [G_FSK, C_FSK] = gramSchmidtSE(fskElements, 'incremental');

M = 4;
h = 1/4;
ovs = 64;

fskElements = generateFSKSignalElements(M,h,ovs,0);

t = (0:ovs-1)/ovs;

figure;



plot(t,real(fskElements(k,:)))

% ========================================================================
% END OF FILE | DICO-LAB4-SS-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
