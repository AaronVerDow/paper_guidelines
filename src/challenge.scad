include <common.scad>;
include <corners.scad>;
include <paper.scad>;
include <debug.scad>;

function challenge_mode(
    start=10,
    spacing=0.5,
    mult=0.9655,
    header=0.3,
    cutoff=1
) = [start, spacing, mult, header, cutoff];

function start(m) = m[0];
function spacing(m) = m[1];
function mult(m) = m[2];
function header(m) = m[3];
function cutoff(m) = m[4];

hard_mode=challenge_mode();
easy_mode=challenge_mode(start=5, mult=0.9885);

module shrinking_bar_label(p, m, new_height, height) {
    module label(m, halign="right") {
	text(format_two_decimals(height/mult(m)), size=new_height, valign="center", halign=halign, font="ubuntu:bold");
    }
    // remove false to put flipped numbers on left hand side
    // looks worse but harder to write on
    if (mirrored(p) && false) {
	translate([0,new_height/2])
	label(m, "left");
    } else {
	translate([east(p)-west(p),new_height/2])
	label(m);
    }
}

module shrinking_bar(p, m, position, height, dark=false) {
    if ((height > cutoff(m)) && (position > south(p))) {
	if (dark) {
	    new_height = height*spacing(m);
	    translate([west(p),position-new_height])
	    difference() { // the actual bar
		square([east(p)-west(p),new_height]);
		minkowski() {
		    shrinking_bar_label(p, m, new_height, height);
		    circle(d=height/2);
		}
	    }
	    translate([west(p),position-new_height])
	    shrinking_bar_label(p, m, new_height, height);
	    shrinking_bar(p, m, position-new_height,height*mult(m),!dark);
	} else {
	    shrinking_bar(p, m, position-height,height*mult(m),!dark);
	}
    } else {
	echo(str("final height: ", height));
    }
}

module inner_challenge(p, m) {
    // lines get progressively smaller
    translate([west(p),north(p)-header(m)])
    square([east(p)-west(p),header(m)]);
    shrinking_bar(p, m, north(p)-header(m), start(m));
}

module challenge(p, m) {
    trim(p)
    inner_challenge(p, m);
    corners(p);
}

module challenge_debug(p, m) {
    trim(p)
    debug(p, [
	str("start = ", start(m)),
	str("spacing = ", spacing(m)),
	str("mult = ", mult(m)),
	str("header = ", header(m)),
	str("cutoff = ", cutoff(m))
    ])
    inner_challenge(p, m);
    corners(p);
}

module challenge_back(p, m) {
    trim(p)
    inner_challenge(mirror_paper(p), m);
    corners(p);
}

paper = lihit_a5_5mm_1o5x();
mode = hard_mode;
challenge_debug(paper, mode);

translate([-x(paper),0]) 
challenge_back(paper, mode);
