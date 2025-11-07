#!/usr/bin/env python

import subprocess
import papersize
import os


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


def safe_number(number) -> str:
    # number to use in filenames
    str_num = f"{number:.1f}"
    return str_num.replace(".", "o")


def render(outdir, paper, style, space, line, label, mirror, debug):
    safe_space = safe_number(space)
    safe_line = f"x{safe_number(line)}"
    dir = os.path.join(outdir, paper, style, safe_space, safe_line)

    if not os.path.isdir(dir):
        os.mkdir(dir)

    basename = f"{paper}_{style}_{safe_space}"
    if line != 1:
        basename = f"{basename}_{safe_line}"
    if label:
        basename = f"{basename}_labeled"
    if mirror:
        basename = f"{basename}_rev"

    outfile = f"

    return


def main():
    root = get_git_root()
    outdir = f"{root}/out"

    for paper in papers():
        for style in styles:
            for space in spaces:
                for line in lines:
                    render(outdir, paper, style, space, line, label, mirror, debug)


#  openscad test.scad -O export-svg/fill=true -O export-svg/stroke=false -O export-svg/fill-color=black -o test.svg -D x=300
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
