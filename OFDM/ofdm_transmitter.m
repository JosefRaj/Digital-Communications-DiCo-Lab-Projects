% =========================================================================
% DICO LAB COURSE | PROJECT 4 - OFDM | SUMMER 2026
% STUDENT STARTER FILE
% FILE-SET ID: DICO-LAB4-S26-v1.0
% Release date: 2026-07-30
% File: ofdm_transmitter.m
% Purpose: Incomplete OFDM transmitter for L-4.3 to L-4.5.
% =========================================================================
function traSignal = ofdm_transmitter(traBits, M)
%OFDM_TRANSMITTER Student implementation for Lab Exercises L-4.3--L-4.5.

validateattributes(traBits, {'numeric', 'logical'}, {'vector', 'nonempty'}, ...
    mfilename, 'traBits');
traBits = double(reshape(traBits, 1, []));
if any(traBits ~= 0 & traBits ~= 1)
    error('DICO:OFDM:NonBinaryInput', 'traBits must contain only 0 and 1.');
end
[D, ~] = ofdm_parameters();
bitsPerSymbol = log2(M);
if bitsPerSymbol ~= round(bitsPerSymbol)
    error('DICO:OFDM:InvalidM', 'M must be a power of two.');
end
if mod(numel(traBits), D*bitsPerSymbol) ~= 0
    error('DICO:OFDM:IncompleteOFDMBlock', ...
        'The input must contain a multiple of D*log2(M) = %d bits.', ...
        D*bitsPerSymbol);
end

traSignal = [];

% TODO(L-4.3):
% 1. Call map_bits_qam.
% 2. Arrange the QAM symbols in rows with D = 8 subchannels.
% Convert bits to QAM symbols
qamSymbols = map_bits_qam(traBits,M);

% Arrange QAM symbols into OFDM blocks
qamSymbols = reshape(qamSymbols,D,[]).';

% Store result
traSignal = qamSymbols;

% TODO(L-4.4):
% Apply an inverse D-point Fourier transform to every row.
timeSignal  = ifft(traSignal, D, 2);



% TODO(L-4.5):
% Determine and add the shortest sufficient cyclic prefix, then serialize
% the OFDM blocks into one row vector.
[~,h] = ofdm_parameters();
cpLength = length(h)-1;

% Copy last CP samples
cyclicPrefix = timeSignal(:,end-cpLength+1:end);
%disp(cyclicPrefix);

% Add cyclic prefix
timeSignal = [cyclicPrefix timeSignal];
%disp(timeSignal);

%disp(qamSymbols)
%disp(timeSignal)

% Convert matrix into one row vector
traSignal = reshape(timeSignal.',1,[]);
%traSignal = reshape(traSignal, 1, []);

%if isempty(traSignal)
 %   error('DICO:OFDM:TodoTransmitter', ...
 %       'Complete Lab Exercises L-4.3 to L-4.5 in ofdm_transmitter.m.');
%end
%traSignal = reshape(traSignal, 1, []);
%end

% =========================================================================
% END OF FILE | DICO-LAB4-S26-v1.0 | SUMMER 2026
% =========================================================================
