#!/usr/bin/env python

import subprocess
import papersize


def get_git_root() -> str:
    result = subprocess.run(
        ["git", "rev-parse", "--show-toplevel"],
        capture_output=True,
        text=True,  # Decode stdout/stderr as text
        check=True,  # Raise an exception for non-zero exit codes
    )
    return result.stdout.strip()


def papers() -> list[str]:
    return list(papersize.SIZES.keys())


styles: list[str] = ["lines", "dots", "grid", "bars", "stepped"]

spaces: list[float] = [x * 0.5 for x in range(4, 15)]
lines: list[float] = [1.0, 1.5]


def execute():
    for paper in papers():
        for style in styles:
            for space in spaces:
                for line in lines:
                    print(f"{paper}_{style}_{space}_x{line}")
                    print(f"{paper}_{style}_{space}_x{line}_rev")
                    print(f"{paper}_{style}_{space}_x{line}_labeled")
                    print(f"{paper}_{style}_{space}_x{line}_labeled_rev")
                    print(f"{paper}_{style}_{space}_x{line}_debug")


# dimensions:
#   types = lines, dots, grid, bars, stepped
#   paper
#   spacing 2.0 - 7.0
#   line spacing 0, 1.5
#   mirrored
#   debug
#   label true/false

if __name__ == "__main__":
    execute()
