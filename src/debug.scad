include <common.scad>;
include <paper.scad>;

debug_font_size=0.8; // multiplied by space
debug_text_gap=2.5;

module debugging_scale(name="") {

    fontsize = 3;
    steps = 15;

    // deugging lines
    fives = 10;
    other = 6;
    thickness = 0.1;

    translate([0,steps+2])
    text(name, halign="center", size=fontsize);
    
    for(y=[-steps:1:steps])
    translate([0,y])
    if (y%5 ==0) {
	square([fives,thickness],center=true);
    } else {
	square([other,thickness],center=true);
    }

    for(y=[-steps:5:steps])
    label(y);

    module label(y) {
	translate([fives/2+1,y])
	text(str(y), valign="center", size=2);

	translate([-fives/2-1,y])
	text(str(y), halign="right", valign="center", size=2);
    }
}

module debugging_lines(p, messages, lines=-1, count=0) {
    text(messages[count], halign="center", valign="center", size=debug_font_size*space(p));

    total_lines = (lines < 0) ? len(messages)-1 : lines;
    if (count < total_lines) {
	translate([0,-step(p)])
	debugging_lines(p, messages, total_lines, count+1);
    }
}

module debug_variables(p, messages=[]) {


    default_messages = [
	str("space = ", space(p), ", line = ", line(p)),
	"",
	str("paper y = ", y(p)),
	str("north = ", north(p), ", margin = ", n(p)),
	str("south = ", south(p), ", margin = ", s(p)),
	"",
	str("paper x = ", x(p)),
	str("east = ", east(p), ", margin = ", e(p)),
	str("west = ", west(p), ", margin = ", w(p)),
	""
    ];

    all = concat(default_messages, messages);

    translate([x(p)/2,north(p)-step(p)*6+ends(p)])
    debugging_lines(p, all);
}

module debug_all(p, messages=[]) {
    debug_edges(p);
    debug_variables(p, messages);
}


module debug_edges(p) {
    translate([x(p)/3,0])
    debugging_scale("x axis");
    translate([x(p)/3*2,south(p)])
    debugging_scale("south");

    translate([x(p)/3*2,y(p)])
    rotate([0,0,180])
    debugging_scale("paper y");
    translate([x(p)/3,north(p)])
    rotate([0,0,180])
    debugging_scale("north");

    translate([x(p),y(p)/3])
    rotate([0,0,90])
    debugging_scale("paper x");
    translate([east(p),y(p)/3*2])
    rotate([0,0,90])
    debugging_scale("east");

    translate([0,y(p)/3*2])
    rotate([0,0,-90])
    debugging_scale("y axis");
    translate([west(p),y(p)/3])
    rotate([0,0,-90])
    debugging_scale("west");
}

module debug(p, messages) {
    difference() {
	children();
	minkowski() {
	    debug_all(p, messages);
	    circle(r=debug_text_gap, $fn=6);
	}
    }
    debug_all(p, messages);
}

// PREVIEW
module test() {
    paper = lihit_a5_5mm_1o5x();
    debug_all(paper, ["extra", "test messages"]);
}
