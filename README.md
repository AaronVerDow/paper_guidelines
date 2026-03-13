# Paper Guidelines

Create gridlines for printing custom notebook paper. Lines are automatically filled and centered within the available space.

Dependencies:
* openscad
* [openscad-post-processor](https://github.com/AaronVerDow/openscad-post-processor)
* librsvg

# Types

## Dots

![](media/all_dots_a5_5mm.png)

## Half Dots

![](media/all_half_dots_a5_5mm.png)

## Lines

![](media/all_lines_a5_5mm.png)

## Half Lines

![](media/all_half_lines_a5_5mm.png)

## Bars

Print solid black and place behind blank paper.

![](media/all_bars_a5_5mm.png)

# Building

* `bin/bulk_render.py`: WIP python script to render all paper and option combinations
* `bin/render.sh`: quick and dirty render script to make what I actually use using `src/all.scad` and `openscad-post-processor`

# Printing 

Brother HL-L2340DW

* Place paper with holes on left hand side
* Print right/front side
* Place paper back in tray, printed side up, holes on right hand side
* Print left/back side
