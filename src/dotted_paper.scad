paper_x = 148;
paper_y = 210;
dot = 1;

$fn=6;

grid = 5;
space = grid;  // where to write
line = grid/2; // thickness of line between spaces
step = space + line;

corner_width = 0.3;
corner_length = 1;

margin = 4;
north_margin = margin + 0;
south_margin = margin + 0;
east_margin = margin + 0;
west_margin = margin + 4;


y_offset = ((paper_y-line-north_margin-south_margin)%step)/2;
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

	for(y=[south+line:step:north])
	translate([x,y])
	circle(d=dot);
    }
}

module bars() {
    for(j=[south:step:north])
    translate([west,j])
    square([east-west,line]);
}

module debugging_scale(name="") {

    fontsize = 5;
    steps = 20;

    // deugging lines
    fives = 10;
    other = 6;
    thickness = 0.3;

    translate([0,steps+2])
    text(name, halign="center", size=fontsize);
    
    for(y=[0:1:steps])
    translate([0,y])
    if (y%5 ==0) {
	square([fives,thickness],center=true);
    } else {
	square([other,thickness],center=true);
    }

    for(y=[0:5:steps])
    label(y);

    module label(y) {
	translate([fives/2+1,y])
	text(str(y), valign="center", size=2);

	translate([-fives/2-1,y])
	text(str(y), halign="right", valign="center", size=2);
    }
}

debugging_line_font_size=3.5;

module debugging_line(message) {
    text(message, halign="center", valign="center", size=debugging_line_font_size);
    translate([0,-step])
    children();
}

module debug_variables() {
    translate([paper_x/2,north-step*6+space/2])
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
    translate([paper_x/2,0])
    debugging_scale("south");

    translate([paper_x/2,paper_y])
    rotate([0,0,180])
    debugging_scale("north");

    translate([paper_x,paper_y/2])
    rotate([0,0,90])
    debugging_scale("east");

    translate([0,paper_y/2])
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


difference() {
    union() {
	bars();
	dots();
    }
    minkowski() {
	debug();
	circle(d=5, $fn=6);
    }
}
debug();
debug_variables();
corners();
