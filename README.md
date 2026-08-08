# Digital Communications (DiCo) Lab Implementations

## Overview
This repository contains a collection of MATLAB simulations exploring fundamental and advanced concepts in digital communications and signal processing. The projects systematically build upon each other to simulate complete transmission systems, from basic baseband modulation to multi-antenna MIMO systems over dispersive channels.

## Projects Included

*   **Project 2: Implementation of Transmitter and Receiver in MATLAB** 
    *   This module implements a complete digital communication system from scratch without any additional hardware components. 
    *   It covers Bit Mapping techniques, including Natural Mapping and Gray Code, for constellations like 4-QAM and bipolar 8-ASK. 
    *   The simulation evaluates system performance by calculating the Bit Error Rate (BER) across an Additive White Gaussian Noise (AWGN) channel.

*   **Project 3: Signal Space Representation** 
    *   This module explores signal orthogonalization and the design of correlation receivers for Maximum Likelihood (ML) detection. 
    *   It features a custom implementation of the Gram-Schmidt Procedure to derive orthonormal basis functions from arbitrary signal elements. 
    *   Additionally, it explores memoryless modulation schemes and M-ary Frequency Shift Keying (FSK).

*   **Project 4: Orthogonal Frequency-Division Multiplexing (OFDM)** 
    *   This project upgrades the transmission system to handle frequency-selective (dispersive) channels using OFDM techniques. 
    *   It utilizes the Inverse Discrete Fourier Transform (IDFT) to generate time-domain OFDM symbols and appends a cyclic prefix to eliminate interblock interference. 
    *   The receiver side includes Frequency Domain Equalization (FEQ) to equalize the effect of scaling factors in the subchannels.

*   **Project 5: Signal Processing in MIMO Systems** 
    *   This module investigates multi-antenna transmission over flat-fading MIMO channels to explore multiplexing and diversity gains. 
    *   It implements and compares Single-Input/Single-Output (SISO) and Single-Input/Multiple-Output (SIMO) setups, including Maximum Ratio Combining (MRC) and Antenna Selection (AS). 
    *   For Multiple-Input/Multiple-Output (MIMO) configurations, it features Zero-Forcing Linear Equalization (ZF-LE), Minimum Mean-Squared Error Linear Equalization (MMSE-LE), and Maximum-Likelihood (ML) Detection algorithms.

## Technologies & Skills
*   **Language:** MATLAB
*   **Core Concepts:** Digital Signal Processing, Telecommunications, Baseband Modulation (QAM/ASK/BPSK), OFDM, MIMO, BER vs. Eb/N0 analysis, Equalization.

## Author
**Yousef Rajabzadeh**

M.Sc. Communications and Multimedia Engineering 

Friedrich-Alexander-Universität Erlangen-Nürnberg (FAU)
