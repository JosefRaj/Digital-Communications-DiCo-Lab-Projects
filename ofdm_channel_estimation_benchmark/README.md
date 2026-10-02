# OFDM Channel-Estimation Benchmark

This project is an independent portfolio extension of authentic undergraduate Digital Communications and DSP coursework and the existing MATLAB communications-laboratory repository. It adds a clean, reproducible Python benchmark comparing pilot-aided LS interpolation with covariance-based LMMSE channel estimation in a multipath OFDM link.

## Coursework connection

The project directly extends verified topics in Digital Communications, Principles of Telecommunication Systems, DSP, Probability, Signals and Systems, and communications/DSP laboratory work. It is kept separate from the original laboratory artifacts so that the new benchmark, assumptions, code, and results are traceable.

## Implemented scope

- QPSK mapping and hard demapping;
- 64-subcarrier OFDM with cyclic prefix and comb pilots;
- stochastic multipath channel with a documented power-delay profile;
- complex AWGN with reproducible random seeds;
- LS estimation at pilots plus periodic linear interpolation;
- LMMSE estimation using the assumed channel covariance and noise variance;
- zero-forcing one-tap equalization;
- BER, EVM and channel-estimation NMSE across an SNR sweep;
- automated tests and generated CSV/SVG/Markdown results.

## Run

```bash
python scripts/run_benchmark.py
python -m unittest discover -s tests -v
```

## Claim boundary

This is a link-level simulation and independent coursework extension, not a measured RF implementation, FAU research project, employer project, or over-the-air prototype. LMMSE uses the true assumed power-delay profile and noise variance; the report explicitly discusses this optimistic information requirement.

## Project summary

> Extended digital-communications coursework with a reproducible Python OFDM benchmark comparing pilot-aided LS and covariance-based LMMSE channel estimation across multipath and SNR conditions using BER, EVM and NMSE.

