include <common.scad>;
include <corners.scad>;
include <paper.scad>;
include <debug.scad>;

module inner_bars(p) {
    for(y=[south(p):step(p):north(p)])
    translate([west(p),y])
    square([east(p)-west(p),line(p)]);
}

module bars_debug(p) {
    trim(p)
    debug(p)
    inner_bars(p);
    corners(p);
}

module bars(p) {
    trim(p)
    inner_bars(p);
    corners(p);
}

bars_debug(lihit_a5_5mm_1o5x(ends="line"));
