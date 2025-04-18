// Common Options
space = 5;  // where to write
line = space/2; // thickness of line between spaces
ends = line;

lihit_a5 = paper(
    x = 148,
    y = 210,
    north = 4,
    south = 4,
    east = 4,
    west = 8
);

paper = lihit_a5;

function paper(
    x,
    y,
    north,
    south,
    east,
    west,
    space = 5,
    line = 2.5,
    ends = "line"
) = [ x, y, north, south, east, west, space, line, ends];

function x(p) = p[0];
function y(p) = p[1];
function n(p) = p[2];
function s(p) = p[3];
function e(p) = p[4];
function w(p) = p[5];
function space(p) = p[6];

function line(p) = p[7];
function ends(p) = (p[8] == "space") 
    ? space(p) 
    : line(p);

grid = space; // deal with this later

function step(p) = space(p)+line(p);
function y_offset(p) = ((y(p)-ends(p)-n(p)-s(p))%step(p))/2;
function south(p) = y_offset(p)+s(p);
function north(p) = y(p)-y_offset(p)-n(p);
function x_offset(p) = (x(p)-e(p)-w(p))/2; // no grid
function west(p) = x_offset(p)+w(p);
function east(p) = x(p)-x_offset(p)-e(p);

// Math
step = space(paper) + line(paper);
y_offset = ((y(paper)-ends(paper)-n(paper)-s(paper))%step)/2;
south = y_offset+s(paper);
north = y(paper)-y_offset-n(paper);
x_offset = ((x(paper)-e(paper)-w(paper))%grid)/2;
west = x_offset+w(paper);
east = x(paper)-x_offset-e(paper);


// Paper Options
paper_x = 148;
paper_y = 210;
margin = 4;
north_margin = margin + 0;
south_margin = margin + 0;
east_margin = margin + 0;
west_margin = margin + 4;

// Dot options
$fn=6;
dot = 1;

// Line options
stripe = 0.1;

// Bar options
// ends must be space

// Challenge options
challenge_header = 0.3; // guide line above first space
challenge_start=10;      // largest area to write
challenge_line_spacing=0.5; // spacing between lines
// challenge_start=5;      // largest area to write
//shrink_factor=0.9885; // how much to shrink each line
shrink_factor=0.9655; // how much to shrink each line
minimum_line=1; // prevents recursion

// Constants
corner_width = 0.3;
corner_length = 1;
debugging_line_font_size=2.5;

// UTILITIES ============================================

module dirror_y(y=0) {
    children();
    translate([0,y])
    mirror([0,1])
    children();
}

module dirror_x(x=0) {
    children();
    translate([x,0])
    mirror([1,0])
    children();
}

module trim() {
    // removes anything outside of paper
    intersection() {
	square([paper_x,paper_y]);
	children();
    }
}

// returns a string rounded and formatted to two decimal places
function format_two_decimals(x) = 
    let (
        integer_part = floor(x),
        fractional_part = round((x - integer_part) * 100),
        padded_fraction = fractional_part < 10 ? str("0", fractional_part) : str(fractional_part)
    )
    str(integer_part, ".", padded_fraction);

module flipped() {
    // use to print double sided patters that are not symmetrical
    translate([paper_x,0])
    mirror([1,0,0])
    children();
}

// CORNERS ============================================

module corner() {
    square([corner_width,corner_length]);
    square([corner_length,corner_width]);
}

module corners() {
    color("red")
    dirror_y(paper_y)
    dirror_x(paper_x)
    corner();
}

// DEBUG ============================================

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

module debugging_line(message) {
    text(message, halign="center", valign="center", size=debugging_line_font_size);
    translate([0,-step])
    children();
}

module debug_variables() {
    translate([paper_x/2,north-step*6+ends])
    debugging_line(str("grid = ", grid, ", space = ", space, ", line = ", line))
    debugging_line(str("global margin = ", margin))
    debugging_line("")
    debugging_line(str("paper_y = ", paper_y))
    debugging_line(str("north = ", north, ", margin = ", north_margin))
    debugging_line(str("south = ", south, ", margin = ", south_margin))
    debugging_line("")
    debugging_line(str("paper_x = ", paper_x))
    debugging_line(str("east = ", east, ", margin = ", east_margin))
    debugging_line(str("west = ", west, ", margin = ", west_margin))
    children();
}

module debug_edges() {
    translate([paper_x/3,0])
    debugging_scale("x axis");
    translate([paper_x/3*2,south])
    debugging_scale("south");

    translate([paper_x/3*2,paper_y])
    rotate([0,0,180])
    debugging_scale("paper_y");
    translate([paper_x/3,north])
    rotate([0,0,180])
    debugging_scale("north");

    translate([paper_x,paper_y/3])
    rotate([0,0,90])
    debugging_scale("paper_x");
    translate([east,paper_y/3*2])
    rotate([0,0,90])
    debugging_scale("east");

    translate([0,paper_y/3*2])
    rotate([0,0,-90])
    debugging_scale("y axis");
    translate([west,paper_y/3])
    rotate([0,0,-90])
    debugging_scale("west");
}

module debug() {
    difference() {
	children();
	minkowski() {
	    debug_edges();
	    circle(d=5, $fn=6);
	}
    }
    debug_edges();
}

// LINES ============================================

module lines() {
    for(y=[south:step:north])
    translate([west,y])
    square([east-west,stripe]);

    for(y=[south+ends:step:north])
    translate([west,y])
    square([east-west,stripe]);
}


// RENDER svg
// RENDER svg2png
module lines_debug() {
    trim()
    debug()
    lines();
    corners();
    debug_variables()
    debugging_line("")
    debugging_line(str("stripe = ", stripe));
}

// RENDER svg
module lines_final() {
    trim()
    bars();
    corners();
}

// BARS ============================================

module bars() {
    for(j=[south:step:north])
    translate([west,j])
    square([east-west,line]);
}

// RENDER svg
module bars_debug() {
    trim()
    debug()
    bars();
    corners();
    debug_variables();
}

// RENDER svg
module bars_final() {
    trim()
    bars();
    corners();
}

// DOTS ============================================

module dots() {
    for(x=[west:grid:east]) {
	for(y=[south:step:north])
	translate([x,y])
	circle(d=dot);

	for(y=[south+ends:step:north])
	translate([x,y])
	circle(d=dot);
    }
}

// RENDER svg
module dots_debug() {
    trim()
    debug()
    dots();
    corners();
    debug_variables()
    debugging_line(str("dot = ", dot));
}

// RENDER svg
module dots_final() {
    trim()
    dots();
    corners();
}



// CHALLENGE ============================================

module shrinking_bar_label(new_height, height) {
    translate([east-west,new_height/2])
    text(format_two_decimals(height/shrink_factor), size=new_height, valign="center", halign="right", font="ubuntu:bold");
}

module shrinking_bar(position, height, dark=false) {
    if ((height > minimum_line) && (position > south)) {
	if (dark) {
	    new_height = height*challenge_line_spacing;
	    translate([west,position-new_height])
	    difference() {
		square([east-west,new_height]);

		minkowski() {
		    shrinking_bar_label(new_height, height);
		    circle(d=height/2);
		}
	    }
	    translate([west,position-new_height])
	    shrinking_bar_label(new_height, height);
	    shrinking_bar(position-new_height,height*shrink_factor,!dark);
	} else {
	    shrinking_bar(position-height,height*shrink_factor,!dark);
	}
    } else {
	echo(str("final height: ", height));
    }
}

module challenge() {
    // lines get progressively smaller
    translate([west,north-challenge_header])
    square([east-west,challenge_header]);
    shrinking_bar(north-challenge_header, challenge_start);
}

// RENDER svg
module challenge_final() {
    trim()
    challenge();
    corners();
}

// RENDER svg
module challenge_flipped() {
    flipped()
    challenge_final();
}

module challenge_debug() {
}

bars_final();
