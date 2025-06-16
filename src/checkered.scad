include <common.scad>;
include <paper.scad>;
include <corners.scad>;
include <debug.scad>;

function checkered_options(
    grid=5,
    label=""
) = [grid, label];

function checkered_spacing(o) = o[0];
function checkered_label(o) = o[1];

// checkered variants of east/west to space squares evenly within margins
// debug currently does not account for this
function gx_offset(p, o) = ((x(p)-e(p)-w(p))%checkered_spacing(o))/2;
function gwest(p, o) = w(p)+gx_offset(p, o);
function geast(p, o) = x(p)-e(p)-gx_offset(p, o);

module checkered_square(p, x, y, o) {
    translate([x, y])
    square([checkered_spacing(o), checkered_spacing(o)]);
}

module inner_checkered(p, o) {
    // Create checkered pattern
    for(y=[south(p):checkered_spacing(o):north(p)]) {
        for(x=[gwest(p, o):checkered_spacing(o):geast(p, o)]) {
            // Create checkered pattern by checking if sum of indices is even
            x_index = floor((x - gwest(p, o)) / checkered_spacing(o));
            y_index = floor((y - south(p)) / checkered_spacing(o));
            if ((x_index + y_index) % 2 == 0) {
                checkered_square(p, x, y, o);
            }
        }
    }

    checkered_pattern_label(p, o);
}

module checkered_pattern_label(p, o) {
    translate([east(p)-checkered_spacing(o),north(p)])
    text(checkered_label(o), halign="center", valign="top", size=checkered_spacing(o), font="Ubuntu:bold");
}

module checkered_debug(p, o) {
    trim(p)
    debug(p, [
        str("checkered_spacing = ", checkered_spacing(o))
    ])
    inner_checkered(p, o);
    corners(p);
}

module checkered(p, o) {
    trim(p)
    inner_checkered(p, o);
    corners(p);
}

checkered_debug(lihit_a5(line=0, ends="space"), checkered_options(label="5.0")); 