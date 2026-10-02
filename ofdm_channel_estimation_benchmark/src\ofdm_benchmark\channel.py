"""Multipath channel generation and analytical frequency covariance."""

from __future__ import annotations

import numpy as np


def normalized_pdp(length: int = 6, decay: float = 0.65) -> np.ndarray:
    if length < 1 or not 0 < decay <= 1:
        raise ValueError("invalid PDP parameters")
    powers = decay ** np.arange(length, dtype=float)
    return powers / powers.sum()


def random_channel(rng: np.random.Generator, pdp: np.ndarray) -> np.ndarray:
    taps = (rng.normal(size=len(pdp)) + 1j * rng.normal(size=len(pdp))) * np.sqrt(pdp / 2)
    return taps


def frequency_covariance(n_subcarriers: int, pdp: np.ndarray) -> np.ndarray:
    subcarriers = np.arange(n_subcarriers)[:, None]
    delays = np.arange(len(pdp))[None, :]
    fourier = np.exp(-2j * np.pi * subcarriers * delays / n_subcarriers)
    return (fourier * pdp[None, :]) @ fourier.conj().T

