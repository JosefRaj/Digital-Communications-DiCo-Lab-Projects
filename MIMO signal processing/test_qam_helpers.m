% ========================================================================
% DICO LAB COURSE - PROJECT 5: SIGNAL PROCESSING IN MIMO SYSTEMS
% SUMMER 2026 | STUDENT STARTER FILE
% File-set ID: DICO-LAB5-MIMO-S26-v1.0
% File: test_qam_helpers.m
% Release date: 2026-07-31
% Use only with files carrying the same file-set ID.
% ========================================================================

%% Sanity checks for the QAM helper functions
% Run after completing GetQAM.m and QuantQAM.m.
rng(7);

for M = [4 16]
    x = GetQAM(300, 400, M);
    assert(isequal(size(x), [300 400]));
    sqrtM = sqrt(M);
    levels = -(sqrtM-1):2:(sqrtM-1);
    assert(all(ismember(real(x(:)), levels)));
    assert(all(ismember(imag(x(:)), levels)));

    empiricalEnergy = mean(abs(x(:)).^2);
    expectedEnergy = qamSymbolVariance(M);
    assert(abs(empiricalEnergy-expectedEnergy)/expectedEnergy < 0.03);

    assert(isequal(QuantQAM(x, M), x));
end

testInput = [-5-5i, -0.2+0.2i, 5+5i];
assert(isequal(QuantQAM(testInput,4), [-1-1i, -1+1i, 1+1i]));

disp('QAM helper sanity checks passed.');

% ========================================================================
% END OF FILE | DICO-LAB5-MIMO-S26-v1.0 | STUDENT FILE | SUMMER 2026
% ========================================================================
