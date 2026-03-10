include <common.scad>;
include <corners.scad>;
include <paper.scad>;
include <debug.scad>;

// Line options
stripe = 1;

module inner_lines(p, stripe) {
    translate([0,-step(p)/4,0]) {
	for(y=[south(p):step(p):north(p)])
	translate([west(p),y])
	square([east(p)-west(p),stripe]);

	for(y=[south(p)+ends(p):step(p):north(p)])
	translate([west(p),y])
	square([east(p)-west(p),stripe]);
    }
}


// RENDER svg
// RENDER svg2png
module lines_debug(p, stripe=0.3) {
    trim(p)
    debug(p, [str("stripe = ", stripe)])
    inner_lines(p, stripe);
    corners(p);
}

// RENDER svg
module lines(p, stripe=0.3, debug=false) {
    if (debug) {
	lines_debug(p, stripe);
    } else {
	trim(p)
	inner_lines(p, stripe);
	corners(p);
    }
}

y=210;
space=y/14;

lines(paper(ends="space", x=148, y=y, east=0, west=0, line=1, north=0, south=0, space=space));
