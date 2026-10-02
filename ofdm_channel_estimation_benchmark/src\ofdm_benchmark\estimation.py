"""Pilot-aided LS interpolation and LMMSE estimation."""

from __future__ import annotations

import numpy as np


def pilot_ls(received: np.ndarray, transmitted: np.ndarray, pilot_indices: np.ndarray) -> np.ndarray:
    return received[pilot_indices] / transmitted[pilot_indices]


def periodic_linear_interpolation(
    pilot_estimates: np.ndarray,
    pilot_indices: np.ndarray,
    n_subcarriers: int,
) -> np.ndarray:
    order = np.argsort(pilot_indices)
    x = np.asarray(pilot_indices)[order]
    y = np.asarray(pilot_estimates)[order]
    extended_x = np.concatenate(([x[-1] - n_subcarriers], x, [x[0] + n_subcarriers]))
    extended_y = np.concatenate(([y[-1]], y, [y[0]]))
    targets = np.arange(n_subcarriers)
    real = np.interp(targets, extended_x, extended_y.real)
    imag = np.interp(targets, extended_x, extended_y.imag)
    return real + 1j * imag


def lmmse_estimate(
    pilot_estimates: np.ndarray,
    pilot_indices: np.ndarray,
    covariance: np.ndarray,
    noise_variance: float,
) -> np.ndarray:
    cross_covariance = covariance[:, pilot_indices]
    pilot_covariance = covariance[np.ix_(pilot_indices, pilot_indices)]
    regularized = pilot_covariance + noise_variance * np.eye(len(pilot_indices))
    weights = np.linalg.solve(regularized, np.asarray(pilot_estimates))
    return cross_covariance @ weights

