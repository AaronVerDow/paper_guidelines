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


def safe_number(number):
    # take a number like 1 or 7.5 and return 1o0 or 7o5
    # use o as decimal and add one digit after the decimal
    pass


def render(outdir, paper, style, space, line, label, mirror, debug):
    basename = f"{paper}_{style}_{space}"
    if line != 1:
        basename = f"{basename}_x{line}"
    if label:
        basename = f"{basename}_labeled"
    if mirror:
        basename = f"{basename}_rev"

    return


def main():
    root = get_git_root()
    outdir = f"{root}/out"

    for paper in papers():
        for style in styles:
            for space in spaces:
                for line in lines:
                    render(outdir, paper, style, space, line, label, mirror, debug)


# openscad grid.scad -O export-svg/fill=true -O export-svg/stroke=false -O export-svg/fill-color=black -o test.svg
# 	rsvg-convert -f pdf -o "$output" "$input"

# dimensions:
#   types = lines, dots, grid, bars, stepped
#   paper
#   spacing 2.0 - 7.0
#   line spacing 0, 1.5
#   mirrored
#   debug
#   label true/false

if __name__ == "__main__":
    main()
