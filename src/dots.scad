include <common.scad>;
include <paper.scad>;
include <corners.scad>;
include <debug.scad>;

function dot_options(
    grid=5,
    diameter=0.3,
    dotfn=12
) = [grid, diameter, dotfn];

function grid(o) = o[0];
function diameter(o) = o[1];
function dotfn(o) = o[2];

// grid variants of east/west to space dots even within margins
// debug currently does not account for this
function gx_offset(p, o) = ((x(p)-e(p)-w(p))%grid(o))/2;
function gwest(p, o) = w(p)+gx_offset(p, o);
function geast(p, o) = x(p)-e(p)-gx_offset(p, o);

module dot(o) {
    circle(d=diameter(o), $fn=dotfn(o));
}

module inner_dots(p, o) {
    for(x=[gwest(p, o):grid(o):geast(p, o)]) {
	for(y=[south(p):step(p):north(p)])
	translate([x,y])
	dot(o);

	for(y=[south(p)+ends(p):step(p):north(p)])
	translate([x,y])
	dot(o);
    }
}

module dots_debug(p, o) {
    trim(p)
    debug(p, [
	str("grid = ", grid(o)),
	str("diameter = ", diameter(o)),
	str("dotfn = ", dotfn(o))
    ])
    inner_dots(p, o);
    corners(p);
}

module dots(p, o, debug=false) {
    if(debug) {
	dots_debug(p, o);
    } else {
	trim(p)
	inner_dots(p, o);
	corners(p);
    }
}

dots_debug(lihit_a5(ends="space"), dot_options());
