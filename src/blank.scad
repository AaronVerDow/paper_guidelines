include <common.scad>;
include <corners.scad>;
include <paper.scad>;
include <debug.scad>;

module blank(p, label="", debug=false) {
    if (debug) {
	bars_debug(p, label="");
    } else {
	corners(p);
    }
}
