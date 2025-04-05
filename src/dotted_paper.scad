// 148 x 210

// how to print 

// openscad-redner file.scad
// open in firefox
// set page size, print to PDF with scale to 10
// set printer size to paper
// notebook holes go on the right
// lp -o fit-to-page=false -o scaling=100 test_dots.pdf -d brother2 -o media=Custom.148x210mm -o print-quality=5
// put paper back in with printed dots up
// print again

paper_x = 148;
paper_y = 210;
dot = 1;
$fn=45;

gap = 5;

corner_width = 0.3;
corner_length = 1;

margin = 1;

holes = 6.5;

spacing = 1.5;

extra = (paper_y%(gap*spacing+gap))/2;

south = extra;
north = paper_y-extra-1;

hole_margin = gap*2;

x_margin = (paper_x%gap)/2;
west = x_margin;
east = paper_x-x_margin-hole_margin;
x_total = east-west;

bar_y=gap*(spacing-1);
bar_x=paper_x-(paper_x%gap);


width = bar_x;
height = bar_y;

density_top = 0.6;    // 90% coverage at top
density_bottom = 0; // 10% coverage at bottom
dot_size=0.03;
dot_step=dot_size;

module corner() {
    square([corner_width,corner_length]);
    square([corner_length,corner_width]);
}

module corners() {
    dirror_y(paper_y)
    dirror_x(paper_x)
    corner();
}

module dots_scaled() {
    scale(10)
    dots();
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

// RENDER svg
module dots() {
    intersection() {
	union() {
	    translate([(paper_x%gap)/2,0])
	    for(i=[0:gap:paper_x])
	    for(j=[south:gap*spacing:north])
	    translate([i,j])
	    circle(d=dot);

	    translate([(paper_x%gap)/2,0])
	    for(i=[0:gap:paper_x])
	    for(j=[south-gap:gap*spacing:north])
	    translate([i,j])
	    circle(d=dot);
	}

	difference() {
	    translate([margin, margin])
	    square([paper_x-margin*2,paper_y-margin*2]);
	    translate([paper_x-holes,paper_y])
	    square([holes,paper_y]);
	}
    }

    corners();
}

// RENDER svg
module bars() {
    corners();

    for(j=[south:gap*spacing:north])
    translate([(paper_x%gap)/2,j-gap*(spacing-1)])
    bar();
}

module bar() {
    square([x_total,gap*(spacing-1)]);
}

bars();
dots();

