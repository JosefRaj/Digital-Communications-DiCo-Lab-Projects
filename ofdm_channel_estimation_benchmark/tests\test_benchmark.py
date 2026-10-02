from __future__ import annotations

import sys
import unittest
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "src"))

from ofdm_benchmark.channel import frequency_covariance, normalized_pdp
from ofdm_benchmark.estimation import lmmse_estimate, periodic_linear_interpolation
from ofdm_benchmark.modulation import qpsk_demap, qpsk_map
from ofdm_benchmark.simulation import BenchmarkConfig, run_benchmark


class BenchmarkTests(unittest.TestCase):
    def test_qpsk_round_trip(self) -> None:
        bits = np.array([0, 0, 0, 1, 1, 0, 1, 1], dtype=np.uint8)
        self.assertTrue(np.array_equal(qpsk_demap(qpsk_map(bits)), bits))

    def test_periodic_interpolation_preserves_pilots(self) -> None:
        indices = np.array([0, 4, 8, 12])
        values = np.array([1 + 0j, 2 + 1j, 0.5 - 1j, -1 + 0.2j])
        estimate = periodic_linear_interpolation(values, indices, 16)
        self.assertTrue(np.allclose(estimate[indices], values))

    def test_covariance_is_hermitian_positive_semidefinite(self) -> None:
        covariance = frequency_covariance(32, normalized_pdp(4))
        self.assertTrue(np.allclose(covariance, covariance.conj().T))
        self.assertGreaterEqual(np.linalg.eigvalsh(covariance).min(), -1e-10)

    def test_lmmse_output_shape_and_finiteness(self) -> None:
        covariance = frequency_covariance(16, normalized_pdp(3))
        pilots = np.array([0, 4, 8, 12])
        estimate = lmmse_estimate(np.ones(4, dtype=complex), pilots, covariance, 0.1)
        self.assertEqual(estimate.shape, (16,))
        self.assertTrue(np.isfinite(estimate).all())

    def test_reproducible_benchmark_and_lmmse_nmse_advantage(self) -> None:
        config = BenchmarkConfig(frames_per_snr=30, seed=9)
        first = run_benchmark([5, 15], config)
        second = run_benchmark([5, 15], config)
        self.assertEqual(first, second)
        for snr in [5.0, 15.0]:
            rows = {row["method"]: row for row in first["results"] if row["snr_db"] == snr}
            self.assertLess(rows["LMMSE"]["channel_nmse"], rows["LS"]["channel_nmse"])


if __name__ == "__main__":
    unittest.main()

