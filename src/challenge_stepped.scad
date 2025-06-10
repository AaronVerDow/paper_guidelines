include <common.scad>;
include <corners.scad>;
include <paper.scad>;
include <debug.scad>;

// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/List_Comprehensions
function quicksort(arr) = !(len(arr)>0) ? [] : let(
    pivot   = arr[floor(len(arr)/2)],
    lesser  = [ for (y = arr) if (y  < pivot) y ],
    equal   = [ for (y = arr) if (y == pivot) y ],
    greater = [ for (y = arr) if (y  > pivot) y ]
) concat(
    quicksort(lesser), equal, quicksort(greater)
);

function total_line(height, spacing) = height + height * spacing;

function loop_current(maximum, minimum, current) = (current > maximum) 
    ? minimum
    : current;

function reset_max(maximum, minimum, step, spacing, space, current, array=[]) = 
    (
	(current <= minimum) ||
	(maximum == minimum) ||
	( space < total_line(minimum, spacing))
    )
    ? quicksort(array)
    : cutlist(current - step, minimum, step, spacing, space, minimum, array);

function cutlist(maximum, minimum, step, spacing, space, current, array=[]) = 
    (space > total_line(current, spacing))
    ? cutlist(maximum, minimum, step, spacing, space-total_line(current, spacing), loop_current(maximum, minimum, current+step), concat(array, [current]))
    : reset_max(maximum, minimum, step, spacing, space, current, array);

function challenge_mode(
    start=7,
    spacing=0.5,
    step=0.5,
    header=0.3,
    cutoff=1.5
) = [start, spacing, step, header, cutoff];

function start(m) = m[0];
function spacing(m) = m[1];
function step(m) = m[2];
function header(m) = m[3];
function cutoff(m) = m[4];

hard_mode=challenge_mode();

module shrinking_bar_label(p, m, new_height, height) {
    module label(m, halign="right") {
	text(format_two_decimals(height), size=new_height, valign="center", halign=halign, font="ubuntu:bold");
    }
    echo("label = ", height);
    // remove false to put flipped numbers on left hand side
    // looks worse but harder to write on
    if (mirrored(p) && false) {
	translate([0,new_height/2])
	label(m, "left");
    } else {
	translate([east(p)-west(p),new_height/2])
	label(m);
    }
}

module shrinking_bar(p, m, cutlist, position, n, dark=false) {
    echo("n = ", n);
    echo("height = ", cutlist[n]);
    height = cutlist[n];
    if ((n >= 0) && (position > south(p))) {
	if (dark) {
	    echo("dark");
	    new_height = height*spacing(m);
	    translate([west(p),position-new_height])
	    difference() { // the actual bar
		square([east(p)-west(p),new_height]);
		minkowski() {
		    shrinking_bar_label(p, m, new_height, height);
		    circle(d=height/2);
		}
	    }
	    translate([west(p),position-new_height])
	    shrinking_bar_label(p, m, new_height, height);
	    shrinking_bar(p, m, cutlist, position-new_height,n - 1,!dark);
	} else {
	    echo("light");
	    shrinking_bar(p, m, cutlist, position-height,n,!dark);
	}
    }
}

module inner_challenge(p, m) {

    cutlist = cutlist(
	maximum = start(m), 
	minimum = cutoff(m),
	step = step(m),
	spacing = spacing(m),
	space = north(p) - south(p),
	current = cutoff(m)
    );
    echo(cutlist);

    // lines get progressively smaller
    translate([west(p),north(p)-header(m)])
    square([east(p)-west(p),header(m)]);
    shrinking_bar(p, m, cutlist, north(p)-header(m), len(cutlist) - 1);
}

module challenge_debug(p, m) {
    trim(p)
    debug(p, [
	str("start = ", start(m)),
	str("spacing = ", spacing(m)),
	str("step = ", step(m)),
	str("header = ", header(m)),
	str("cutoff = ", cutoff(m))
    ])
    inner_challenge(p, m);
    corners(p);
}

module challenge_back(p, m=hard_mode) {
    trim(p)
    inner_challenge(mirror_paper(p), m);
    corners(p);
}

module challenge(p, m=hard_mode) {
    trim(p)
    inner_challenge(p, m);
    corners(p);
}

paper = lihit_a5();
mode = hard_mode;
challenge_debug(paper, mode);

//translate([-x(paper),0]) 
//challenge_back(paper, mode);
