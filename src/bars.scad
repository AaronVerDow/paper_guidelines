include <common.scad>;
include <corners.scad>;
include <paper.scad>;
include <debug.scad>;

module inner_bars(p, label) {
    bar_label(p, label);

    difference() {
	for(y=[south(p):step(p):north(p)])
	translate([west(p),y])
	square([east(p)-west(p),line(p)]);
	
	minkowski() {
	    bar_label(p, label);
	    circle(d=line(p));
	}
    }
}

module bars_debug(p, label="") {
    trim(p)
    debug(p)
    inner_bars(p, label);
    corners(p);
}

module bar_label(p, label) {
    translate([east(p),north(p)])
    text(label, halign="right", valign="top", size=line(p), font="Ubuntu:bold");
}

module bars(p, label="") {
    trim(p)
    inner_bars(p, label);
    corners(p);
}

bars_debug(lihit_a5_5mm_1o5x(ends="line"), "1.5x 5.0");
