# Generated OFDM Benchmark Summary

## Configuration

```json
{
  "n_subcarriers": 64,
  "cyclic_prefix": 16,
  "pilot_spacing": 4,
  "channel_length": 6,
  "channel_decay": 0.65,
  "frames_per_snr": 160,
  "seed": 2026
}
```

## Results

| SNR dB | Estimator | BER | EVM | Channel NMSE |
|---:|---|---:|---:|---:|
| 0 | LS | 0.28444 | 2.9734 | 0.88200 |
| 0 | LMMSE | 0.25534 | 3.5668 | 0.30144 |
| 5 | LS | 0.17122 | 1.9029 | 0.30435 |
| 5 | LMMSE | 0.14570 | 2.0919 | 0.13216 |
| 10 | LS | 0.07611 | 1.3685 | 0.09756 |
| 10 | LMMSE | 0.06016 | 1.0325 | 0.04310 |
| 15 | LS | 0.03275 | 0.9540 | 0.04358 |
| 15 | LMMSE | 0.02116 | 0.9026 | 0.01613 |
| 20 | LS | 0.01478 | 0.5860 | 0.02136 |
| 20 | LMMSE | 0.00671 | 0.3285 | 0.00496 |
| 25 | LS | 0.00742 | 0.3592 | 0.01497 |
| 25 | LMMSE | 0.00241 | 0.2692 | 0.00151 |

## Interpretation

LMMSE uses an assumed channel covariance derived from the same power-delay profile used by the generator, plus the simulated noise variance. It should therefore provide lower channel-estimation error than pilot-only LS interpolation when those assumptions match. This advantage comes with matrix-solve complexity and sensitivity to covariance/noise mismatch. LS interpolation is simpler and requires less prior knowledge, but sparse pilots and frequency-selective fading create interpolation error.

In this run, LMMSE improves BER and channel NMSE at every tested SNR, while its post-equalization EVM is not lower at the two lowest SNR points. This is not hidden: the one-tap zero-forcing equalizer can strongly amplify noise on subcarriers with small estimated channel magnitude, and an average EVM can be dominated by those outliers even when hard-decision BER improves. A follow-up should compare clipped ZF and MMSE equalization and report EVM percentiles.

The experiment is a reproducible link-level simulation. It does not include synchronization error, carrier-frequency offset, phase noise, nonlinear RF components, channel coding, measured channels, or over-the-air validation.
