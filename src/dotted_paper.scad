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

margin = 1;


spacing = 1.5;

y_margin = ((paper_y-line)%step)/2;
south = y_margin;
north = paper_y-y_margin;

x_margin = (paper_x%grid)/2;
west = x_margin;
east = paper_x-x_margin;

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
    translate([x_margin,j])
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
    translate([paper_x/2,north-step*8+space/2])
    debugging_line(str("paper_y = ", paper_y))
    debugging_line(str("north = ", north))
    debugging_line(str("south = ", south))
    debugging_line(str("paper_x = ", paper_x))
    debugging_line(str("east = ", east))
    debugging_line(str("west = ", west))
    debugging_line(str("grid = ", grid))
    debugging_line(str("line = ", line))
    ;
}

module debug() {
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
