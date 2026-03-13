include <bars.scad>;
include <challenge.scad>;
include <stepped.scad>;
include <paper.scad>;
include <dots.scad>;
include <lines.scad>;
include <grid.scad>;
include <table_of_contents.scad>;
// NOPREVIEW

module bulk_lines(x, y, north, south, east, west, space, line, label, mirrored, debug) {
    lines(
	paper(x, y, north, south, east, west, space, line, "space")
    );
}

module bulk_dots(x, y, north, south, east, west, space, line, label, mirrored, debug) {
    dots(
	paper(x, y, north, south, east, west, space, line, "space"),
	dot_options()
    );
}

module bulk_grid(x, y, north, south, east, west, space, line, label, mirrored, debug) {
    grid(
	paper(x, y, north, south, east, west, space, line, "space"),
	grid_options(grid=space, label=label)
    );
}

module bulk_bars(x, y, north, south, east, west, space, line, label, mirrored, debug) {
    bars(
	paper(x, y, north, south, east, west, space, line, "line"),
	label
    );
}

module bulk_stepped(x, y, north, south, east, west, space, line, label, mirrored, debug) {
    stepped(
	paper(x, y, north, south, east, west, space, line, "line"),
	small_mode
    );
}
