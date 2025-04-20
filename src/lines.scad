include <common.scad>;
include <corners.scad>;
include <paper.scad>;
include <debug.scad>;

// Line options
stripe = 0.1;

module inner_lines(p, stripe) {
    for(y=[south(p):step(p):north(p)])
    translate([west(p),y])
    square([east(p)-west(p),stripe]);

    for(y=[south(p)+ends(p):step(p):north(p)])
    translate([west(p),y])
    square([east(p)-west(p),stripe]);
}


// RENDER svg
// RENDER svg2png
module lines_debug(p, stripe=0.3) {
    trim(p)
    debug(p, [str("stripe = ", stripe)])
    inner_lines(p, stripe);
    corners();
}

// RENDER svg
module lines(p, stripe=0.3) {
    trim(p)
    inner_lines(p, stripe);
    corners(p);
}

lines_debug(lihit_a5(ends="space"));
