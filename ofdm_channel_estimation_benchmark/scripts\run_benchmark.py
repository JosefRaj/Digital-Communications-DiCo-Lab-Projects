from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "src"))

from ofdm_benchmark.report import write_outputs
from ofdm_benchmark.simulation import BenchmarkConfig, run_benchmark


def main() -> None:
    config = BenchmarkConfig(frames_per_snr=160, seed=2026)
    result = run_benchmark([0, 5, 10, 15, 20, 25], config)
    output = ROOT / "reports" / "generated"
    write_outputs(result, output)
    print((output / "engineering_summary.md").read_text(encoding="utf-8"))


if __name__ == "__main__":
    main()

