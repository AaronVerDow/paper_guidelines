include <common.scad>;
include <paper.scad>;
include <corners.scad>;
include <debug.scad>;

function grid_options(
    grid=5,
    line_width=0.1,
    label=""
) = [grid, line_width, label];

function grid_spacing(o) = o[0];
function line_width(o) = o[1];
function label(o) = o[2];

// grid variants of east/west to space grid lines evenly within margins
// debug currently does not account for this
function gx_offset(p, o) = ((x(p)-e(p)-w(p))%grid_spacing(o))/2;
function gwest(p, o) = w(p)+gx_offset(p, o);
function geast(p, o) = x(p)-e(p)-gx_offset(p, o);

module grid_line_horizontal(p, y, o) {
    translate([gwest(p, o), y])
    square([geast(p, o) - gwest(p, o), line_width(o)]);
}

module grid_line_vertical(p, x, o) {
    translate([x, south(p)])
    square([line_width(o), north(p) - south(p)]);
}

module inner_grid(p, o) {
    difference() {
        inner_inner_grid(p, o);
        grid_label(p, o);
    }
    hollow_grid_label(p, o);
}

module inner_inner_grid(p, o) {
    // Horizontal lines
    for(y=[south(p):step(p):north(p)]) {
        grid_line_horizontal(p, y, o);
    }
    
    for(y=[south(p)+ends(p):step(p):north(p)]) {
        grid_line_horizontal(p, y, o);
    }
    
    // Vertical lines
    for(x=[gwest(p, o):grid_spacing(o):geast(p, o)]) {
        grid_line_vertical(p, x, o);
    }

}

module hollow_grid_label(p, o) {
    difference() {
        grid_label(p, o);
        offset(-line_width(o))
        grid_label(p, o);
    }
}

module grid_label(p, o) {
    translate([east(p)-grid_spacing(o),north(p)])
    text(label(o), halign="center", valign="top", size=grid_spacing(o), font="Ubuntu:bold");
}

module grid_debug(p, o) {
    trim(p)
    debug(p, [
        str("grid_spacing = ", grid_spacing(o)),
        str("line_width = ", line_width(o))
    ])
    inner_grid(p, o);
    corners(p);
}

module grid(p, o) {
    trim(p)
    inner_grid(p, o);
    corners(p);
}

grid_debug(lihit_a5(line=0, ends="space"), grid_options(label="5.0"));
