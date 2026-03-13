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
    if (back(p)) {
	translate([west(p),north(p)])
	text(label, halign="left", valign="top", size=line(p), font="Ubuntu:bold");
    } else {
	translate([east(p),north(p)])
	text(label, halign="right", valign="top", size=line(p), font="Ubuntu:bold");

	translate([east(p),south(p)])
	rotate([0,0,180])
	text(label, halign="left", valign="top", size=line(p), font="Ubuntu:bold");
    }
}


module bars(p, label="", debug=false) {
    if (debug) {
	bars_debug(p, label="");
    } else {
	trim(p)
	inner_bars(p, label);
	corners(p);
    }
}

module page_numbers(p) {
    digits=4;
    line=0.3;
    size=2.5;
    delta=line+size;
    total_x=digits*delta+line;
    total_y=size+line*2;
    //center
    //translate([(east(p)-west(p))/2+west(p),south(p)/2])
    translate([east(p),south(p)/2])
    translate([-total_x,-total_y/2])
    difference() {
	square([digits*delta+line,size+line*2]);
	for(n=[0:1:digits-1]) {
	translate([line+delta*n,line])
	square([size,size]);
	}
    }
}

page_numbers(lihit_a5());

// bars_debug(mirror_paper(lihit_a5()), "1.5x 5.0");
bars(lihit_a5(5), "5.0");
