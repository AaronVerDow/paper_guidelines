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


def x(paper):
    return float(papersize.parse_papersize(paper, "mm")[0])


def y(paper):
    return float(papersize.parse_papersize(paper, "mm")[1])


def scad_contents(style):
    return f"""
use <src/bulk.scad>;

x=100;
y=100;
margin = 5;
space = 5;
line = 0.5;
mirrored = 0;
debug = 0;
label = "test";

bulk_{style}(x, y, margin, margin, margin, margin, space, line, label, mirrored, debug);
    """


def render(infile, outdir, paper, style, space, line, label, margin_ratio, mirror, debug):
    safe_space = safe_number(space)
    safe_line = f"x{safe_number(line)}"
    dir = os.path.join(outdir, paper, style, safe_space, safe_line)

    if not os.path.isdir(dir):
        os.makedirs(dir, exist_ok=True)

    basename = f"{paper}_{style}_{safe_space}"
    if line != 1:
        basename = f"{basename}_{safe_line}"
    if label:
        basename = f"{basename}_labeled"
    if mirror:
        basename = f"{basename}_rev"

    svgfile = os.path.join(dir, f"{basename}.svg")
    pdffile = os.path.join(dir, f"{basename}.pdf")

    margin = margin_ratio * x(paper)

    subprocess.run(
        [
            "openscad",
            infile,
            "-O",
            "export-svg/fill=true",
            "-O",
            "export-svg/stroke=false",
            "-O",
            "export-svg/fill-color=black",
            "-o",
            svgfile,
            "-D",
            f"x={x(paper)}",
            "-D",
            f"y={y(paper)}",
            "-D",
            f"space={space}",
            "-D",
            f"line={line-1}",
            "-D",
            f"mirrored={int(mirror)}",
            "-D",
            f"debug={int(debug)}",
            "-D",
            f"label={label}",
            "-D",
            f"margin={margin}",
        ],
        check=True,
    )

    subprocess.run(["rsvg-convert", "-f", "pdf", "-o", pdffile, svgfile], check=True)

    os.remove(svgfile)


def main():
    root = get_git_root()
    outdir = f"{root}/out"
    infile = f"{root}/infile.scad"

    margin_ratio = 4 / 148

    mirror = 0
    debug = 0
    label = ""

    for paper in papers():
        for style in styles:
            with open(infile, "w") as file_object:
                file_object.write(scad_contents(style))
            for space in spaces:
                for line in lines:
                    render(infile, outdir, paper, style, space, line, label, margin_ratio, mirror, debug)


if __name__ == "__main__":
    main()
