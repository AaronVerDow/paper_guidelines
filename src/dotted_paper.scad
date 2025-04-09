paper_x = 148;
paper_y = 210;
dot = 1;

$fn=6;

grid = 5;
space = grid;  // where to write
line = grid/2; // thickness of line between spaces
step = space + line;

// thin lines
stripe = 0.1;

corner_width = 0.3;
corner_length = 1;

margin = 4;
north_margin = margin + 0;
south_margin = margin + 0;
east_margin = margin + 0;
west_margin = margin + 4;

// define what the top and bottom ends should be
// dots can be line or space
// bars must be line (for now)
ends=line;

y_offset = ((paper_y-ends-north_margin-south_margin)%step)/2;
south = y_offset+south_margin;
north = paper_y-y_offset-north_margin;

x_offset = ((paper_x-east_margin-west_margin)%grid)/2;
west = x_offset+west_margin;
east = paper_x-x_offset-east_margin;

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

module lines() {
    for(y=[south:step:north])
    translate([west,y])
    square([east-west,stripe]);

    for(y=[south+ends:step:north])
    translate([west,y])
    square([east-west,stripe]);
}

module bars() {
    for(j=[south:step:north])
    translate([west,j])
    square([east-west,line]);
}

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

debugging_line_font_size=2.5;

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

module trim() {
    // removes anything outside of paper
    intersection() {
	square([paper_x,paper_y]);
	children();
    }
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

// mode where lines get progressively smaller

challenge_header = 0.3; // guide line above first space
// challenge_start=5;      // largest area to write
challenge_start=10;      // largest area to write
challenge_line_spacing=0.5; // spacing between lines
//shrink_factor=0.9885; // how much to shrink each line
shrink_factor=0.9655; // how much to shrink each line
minimum_line=1; // prevents recursion
challenge_text_scale=0.6;

// returns a string rounded and formatted to two decimal places
function format_two_decimals(x) = 
    let (
        integer_part = floor(x),
        fractional_part = round((x - integer_part) * 100),
        padded_fraction = fractional_part < 10 ? str("0", fractional_part) : str(fractional_part)
    )
    str(integer_part, ".", padded_fraction);

module shrinking_bar_label(new_height, height) {
    translate([east-west,new_height/2])
    text(format_two_decimals(height/shrink_factor), size=new_height, valign="center", halign="right", font="Ubuntu:Bold");
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
	echo(str("Final height: ", height));
    }
}

module challenge() {
    // lines get progressively smaller
    translate([west,north-challenge_header])
    square([east-west,challenge_header]);
    shrinking_bar(north-challenge_header, challenge_start);
}

module flipped() {
    // use to print double sided patters that are not symmetrical
    translate([paper_x,0])
    mirror([1,0,0])
    children();
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

!challenge();

difference() {
    union() {
	//bars();
	//dots();
	//lines();
	challenge();
    }
    minkowski() {
	debug();
	circle(d=7, $fn=6);
    }
}
debug();
debug_variables();
corners();
