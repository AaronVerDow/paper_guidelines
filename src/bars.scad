include <common.scad>;
include <corners.scad>;
include <paper.scad>;
include <debug.scad>;
include <page_numbers.scad>;

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
    module reverse_number(p) {
    }

    if (back(p)) {
	translate([west(p),north(p)])
	text(label, halign="left", valign="top", size=line(p), font="Ubuntu:bold");

	if(reversible(p)) {
	    translate([west(p),south(p)])
	    rotate([0,0,180])
	    text(label, halign="right", valign="top", size=line(p), font="Ubuntu:bold");
	}

    } else {
	translate([east(p),north(p)])
	text(label, halign="right", valign="top", size=line(p), font="Ubuntu:bold");

	if(reversible(p)) {
	    translate([east(p),south(p)])
	    rotate([0,0,180])
	    text(label, halign="left", valign="top", size=line(p), font="Ubuntu:bold");
	}
    }
}


module bars(p, label="", debug=false) {
    if (debug) {
	bars_debug(p, label="");
    } else {
	trim(p)
	inner_bars(p, label);
	page_numbers(p);
	corners(p);
    }
}


// bars_debug(mirror_paper(lihit_a5()), "1.5x 5.0");
bars(lihit_a5(5, loose=false), "5.0");
//bars(mirror_paper(lihit_a5(5, loose=false)), "5.0");
