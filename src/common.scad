// NOPREVIEW

// Constants
corner_width = 0.3;
corner_length = 1;
debugging_line_font_size=2.5;

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

function step(p) = space(p)+line(p);
function y_offset(p) = ((y(p)-ends(p)-n(p)-s(p))%step(p))/2;
function south(p) = y_offset(p)+s(p);
function north(p) = y(p)-y_offset(p)-n(p);
function west(p) = w(p);
function east(p) = x(p)-e(p);
function x_offset(p) = west(p);

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

module trim(p) {
    // removes anything outside of paper
    intersection() {
	square([x(p),y(p)]);
	children();
    }
}

function format_two_decimals(x) = 
    // returns a string rounded and formatted to two decimal places
    let (
        integer_part = floor(x),
        fractional_part = round((x - integer_part) * 100),
        padded_fraction = fractional_part < 10 ? str("0", fractional_part) : str(fractional_part)
    )
    str(integer_part, ".", padded_fraction);

module flipped(p) {
    // use to print double sided patters that are not symmetrical
    translate([x(p),0])
    mirror([1,0,0])
    children();
}
