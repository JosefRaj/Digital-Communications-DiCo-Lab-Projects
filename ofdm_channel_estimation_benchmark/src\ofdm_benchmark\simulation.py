"""Monte Carlo OFDM benchmark."""

from __future__ import annotations

from dataclasses import asdict, dataclass

import numpy as np

from .channel import frequency_covariance, normalized_pdp, random_channel
from .estimation import lmmse_estimate, periodic_linear_interpolation, pilot_ls
from .metrics import bit_error_rate, error_vector_magnitude, normalized_mse
from .modulation import qpsk_demap, qpsk_map


@dataclass(frozen=True)
class BenchmarkConfig:
    n_subcarriers: int = 64
    cyclic_prefix: int = 16
    pilot_spacing: int = 4
    channel_length: int = 6
    channel_decay: float = 0.65
    frames_per_snr: int = 160
    seed: int = 2026


def _equalize(received: np.ndarray, estimate: np.ndarray) -> np.ndarray:
    floor = 1e-9
    safe = np.where(np.abs(estimate) < floor, floor + 0j, estimate)
    return received / safe


def run_benchmark(snr_db_values: list[float], config: BenchmarkConfig = BenchmarkConfig()) -> dict[str, object]:
    if config.cyclic_prefix < config.channel_length - 1:
        raise ValueError("cyclic prefix must cover the channel memory")
    rng = np.random.default_rng(config.seed)
    n = config.n_subcarriers
    pilots = np.arange(0, n, config.pilot_spacing, dtype=int)
    data_indices = np.setdiff1d(np.arange(n), pilots)
    pilot_symbol = (1 + 1j) / np.sqrt(2)
    pdp = normalized_pdp(config.channel_length, config.channel_decay)
    covariance = frequency_covariance(n, pdp)
    rows: list[dict[str, float | str]] = []

    for snr_db in snr_db_values:
        accumulators = {
            "LS": {"bit_errors": 0, "bits": 0, "evm_sq_sum": 0.0, "evm_symbols": 0, "nmse_sum": 0.0},
            "LMMSE": {"bit_errors": 0, "bits": 0, "evm_sq_sum": 0.0, "evm_symbols": 0, "nmse_sum": 0.0},
        }
        snr_linear = 10 ** (snr_db / 10)
        noise_variance = 1.0 / snr_linear

        for _ in range(config.frames_per_snr):
            bits = rng.integers(0, 2, size=2 * len(data_indices), dtype=np.uint8)
            data_symbols = qpsk_map(bits)
            frequency_symbols = np.zeros(n, dtype=complex)
            frequency_symbols[pilots] = pilot_symbol
            frequency_symbols[data_indices] = data_symbols
            time_symbol = np.fft.ifft(frequency_symbols) * np.sqrt(n)
            transmitted = np.concatenate((time_symbol[-config.cyclic_prefix :], time_symbol))

            channel = random_channel(rng, pdp)
            channel_output = np.convolve(transmitted, channel)[: len(transmitted)]
            noise = np.sqrt(noise_variance / 2) * (
                rng.normal(size=len(channel_output)) + 1j * rng.normal(size=len(channel_output))
            )
            received_time = channel_output + noise
            received_frequency = np.fft.fft(
                received_time[config.cyclic_prefix : config.cyclic_prefix + n]
            ) / np.sqrt(n)
            true_channel = np.fft.fft(channel, n)
            pilot_estimates = pilot_ls(received_frequency, frequency_symbols, pilots)
            estimates = {
                "LS": periodic_linear_interpolation(pilot_estimates, pilots, n),
                "LMMSE": lmmse_estimate(pilot_estimates, pilots, covariance, noise_variance),
            }

            for method, channel_estimate in estimates.items():
                equalized = _equalize(received_frequency, channel_estimate)[data_indices]
                detected_bits = qpsk_demap(equalized)
                stats = accumulators[method]
                stats["bit_errors"] += int(np.sum(bits != detected_bits))
                stats["bits"] += len(bits)
                stats["evm_sq_sum"] += float(np.sum(np.abs(data_symbols - equalized) ** 2))
                stats["evm_symbols"] += len(data_symbols)
                stats["nmse_sum"] += normalized_mse(true_channel, channel_estimate)

        for method, stats in accumulators.items():
            rows.append(
                {
                    "snr_db": float(snr_db),
                    "method": method,
                    "ber": float(stats["bit_errors"] / stats["bits"]),
                    "evm": float(np.sqrt(stats["evm_sq_sum"] / stats["evm_symbols"])),
                    "channel_nmse": float(stats["nmse_sum"] / config.frames_per_snr),
                }
            )
    return {"config": asdict(config), "pilot_indices": pilots.tolist(), "results": rows}

