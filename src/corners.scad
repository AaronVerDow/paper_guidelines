// NOPREVIEW

corner_width = 0.3;
corner_length = 1;

module corner() {
    square([corner_width,corner_length]);
    square([corner_length,corner_width]);
}

module corners(p) {
    color("red")
    dirror_y(y(p))
    dirror_x(x(p))
    corner();
}
