// NOPREVIEW

// Constants
corner_width = 0.1;
corner_length = 0.1;
debugging_line_font_size=2.5;

function paper(
    x,
    y,
    north,
    south,
    east,
    west,
    space = 5,
    line = 0.5,
    ends = "line",
    back = false,
    reversible = false,
    numbered = false
) = [ x, y, north, south, east, west, space, line, ends, back, reversible, numbered];

function mirror_paper(p) = [
    x(p),
    y(p),
    n(p),
    s(p),
    w(p), // flip east and west
    e(p),
    space(p),
    p[7],
    p[8],
    true,
    p[10],
    p[11]
];

function x(p) = p[0];
function y(p) = p[1];
function n(p) = p[2];
function s(p) = p[3];
function e(p) = p[4];
function w(p) = p[5];
function space(p) = p[6];

function line(p) = p[7] * space(p);
function ends(p) = (p[8] == "space") 
    ? space(p) 
    : line(p);
function back(p) = p[9];
function reversible(p) = p[10];
function numbered(p) = p[11];

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

function format_one_decimal(x) = 
    // returns a string rounded and formatted to two decimal places
    let (
        integer_part = floor(x),
        fractional_part = round((x - integer_part) * 10)
    )
    str(integer_part, ".", fractional_part);

module flipped(p) {
    // use to print double sided patters that are not symmetrical
    translate([x(p),0])
    mirror([1,0,0])
    children();
}
