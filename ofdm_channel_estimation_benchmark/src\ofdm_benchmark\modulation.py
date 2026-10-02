"""Unit-energy Gray-coded QPSK mapping and hard decisions."""

from __future__ import annotations

import numpy as np


def qpsk_map(bits: np.ndarray) -> np.ndarray:
    values = np.asarray(bits, dtype=np.uint8)
    if values.ndim != 1 or len(values) % 2:
        raise ValueError("QPSK requires a flat even-length bit array")
    pairs = values.reshape(-1, 2)
    return ((1 - 2 * pairs[:, 0].astype(float)) + 1j * (1 - 2 * pairs[:, 1].astype(float))) / np.sqrt(2)


def qpsk_demap(symbols: np.ndarray) -> np.ndarray:
    values = np.asarray(symbols, dtype=complex)
    bits = np.empty(values.size * 2, dtype=np.uint8)
    bits[0::2] = values.real < 0
    bits[1::2] = values.imag < 0
    return bits

