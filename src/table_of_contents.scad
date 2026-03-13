include <common.scad>;
include <corners.scad>;
include <paper.scad>;
include <debug.scad>;

module inner_toc(p, label) {
    toc_label(p, label);

    difference() {
	for(y=[south(p):step(p):north(p)])
	translate([west(p),y])
	square([east(p)-west(p),line(p)]);
	
	minkowski() {
	    toc_label(p, label);
	    circle(d=line(p));
	}
    }
}

module toc_debug(p, label="") {
    trim(p)
    debug(p)
    inner_toc(p, label);
    corners(p);
    trim(p)
    divider(p);
}

module toc_label(p, label) {
    if (back(p)) {
	translate([west(p),north(p)])
	text(label, halign="left", valign="top", size=line(p), font="Ubuntu:bold");
    } else {
	translate([east(p),north(p)])
	text(label, halign="right", valign="top", size=line(p), font="Ubuntu:bold");
    }
}

divider_width=25.4/4;
divider_x=1/4;
module divider(p) {
    dirror_x(x(p))
    translate([-divider_width/2+x(p)*divider_x,south(p)])
    dirror_x()
    translate([-divider_width/2,0])
    square([line(p),north(p)-south(p)]);
}

module toc(p, label="") {
    trim(p)
    inner_toc(p, label);
    corners(p);
    trim(p)
    divider(p);
}

toc_debug(lihit_a5(space=3.5), "3.5");
