"""Communication-system evaluation metrics."""

from __future__ import annotations

import numpy as np


def bit_error_rate(reference: np.ndarray, estimate: np.ndarray) -> float:
    return float(np.mean(np.asarray(reference) != np.asarray(estimate)))


def normalized_mse(reference: np.ndarray, estimate: np.ndarray) -> float:
    numerator = np.mean(np.abs(np.asarray(reference) - np.asarray(estimate)) ** 2)
    denominator = np.mean(np.abs(np.asarray(reference)) ** 2)
    return float(numerator / denominator)


def error_vector_magnitude(reference: np.ndarray, estimate: np.ndarray) -> float:
    numerator = np.mean(np.abs(np.asarray(reference) - np.asarray(estimate)) ** 2)
    denominator = np.mean(np.abs(np.asarray(reference)) ** 2)
    return float(np.sqrt(numerator / denominator))

