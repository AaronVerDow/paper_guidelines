include <common.scad>;
include <corners.scad>;
include <paper.scad>;
include <debug.scad>;

function stepped_mode(
    start=10,
    spacing=0.5,
    sstep=0.5, // conflict with another function
    header=0.3,
    cutoff=2,
    prefer_large=true
) = [start, spacing, sstep, header, cutoff, prefer_large];

large_mode = stepped_mode();

small_mode = stepped_mode(start=7, sstep=0.5, prefer_large=false, cutoff=1);

function start(m) = m[0];
function spacing(m) = m[1];
function sstep(m) = m[2];
function header(m) = m[3];
function cutoff(m) = m[4];
function prefer_large(m) = m[5];

function quicksort(arr) = !(len(arr)>0) ? [] : let(

    pivot   = arr[floor(len(arr)/2)],
    lesser  = [ for (y = arr) if (y  < pivot) y ],
    equal   = [ for (y = arr) if (y == pivot) y ],
    greater = [ for (y = arr) if (y  > pivot) y ]
) concat(
    quicksort(lesser), equal, quicksort(greater)
);

function total_line(height, spacing) = height + height * spacing;

// Prefer smaller lines ==============================

// Reset current to minimum once maximum is surpassed
function loop_max(maximum, minimum, current) = (current > maximum) 
    ? minimum
    : current;

// Lower maximum once a line does not fit on page, the restart from minimum
function reset_max(maximum, minimum, step, spacing, space, current, array=[]) = 
    (
	(current <= minimum) ||
	(maximum == minimum) ||
	( space < total_line(minimum, spacing))
    )
    ? quicksort(array)
    : cutlist(current - step, minimum, step, spacing, space, minimum, array);

// Fill in space staring with smallest lines and moving up. 
// Repeat until lines no longer fit.
// This will repeat lines until space is filled, preferring to repeat smaller lines.
function cutlist(maximum, minimum, step, spacing, space, current, array=[]) = 
    (space > total_line(current, spacing))
    ? cutlist(maximum, minimum, step, spacing, space-total_line(current, spacing), loop_max(maximum, minimum, current+step), concat(array, [current]))
    : reset_max(maximum, minimum, step, spacing, space, current, array);


// Prefer larger lines ==============================

function loop_min(maximum, minimum, current) = (current < minimum) 
    ? maximum
    : current;

// Lower maximum once a line does not fit on page, repeat until it fits or minimum is hit
function decrement_max(maximum, minimum, step, spacing, space, current, array=[]) = 
    (
	(maximum == minimum) ||
	( space < total_line(minimum, spacing))
    )
    ? quicksort(array)
    : cutlist(current - step, minimum, step, spacing, space, current - step, array);

// current should start with maximum 
function cutlist_large(maximum, minimum, step, spacing, space, current, array=[]) = 
    (space > total_line(current, spacing))
    ? cutlist_large(maximum, minimum, step, spacing, space-total_line(current, spacing), loop_min(maximum, minimum, current-step), concat(array, [current]))
    : decrement_max(maximum, minimum, step, spacing, space, current, array);


module shrinking_step_label(p, m, new_height, height) {
    module label(m, halign="right") {
	text(format_two_decimals(height), size=new_height, valign="center", halign=halign, font="ubuntu:bold");
    }
    // echo("label = ", height);
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

module shrinking_step(p, m, cutlist, position, n, dark=false) {
    // echo("n = ", n);
    // echo("height = ", cutlist[n]);
    height = cutlist[n];
    if ((n >= 0) && (position > south(p))) {
	if (dark) {
	    // echo("dark");
	    new_height = height*spacing(m);
	    translate([west(p),position-new_height])
	    difference() { // the actual bar
		square([east(p)-west(p),new_height]);
		minkowski() {
		    shrinking_step_label(p, m, new_height, height);
		    circle(d=height/2);
		}
	    }
	    translate([west(p),position-new_height])
	    shrinking_step_label(p, m, new_height, height);
	    shrinking_step(p, m, cutlist, position-new_height,n - 1,!dark);
	} else {
	    // echo("light");
	    shrinking_step(p, m, cutlist, position-height,n,!dark);
	}
    }
}

function get_cutlist(p, m) = 
    (prefer_large(m))
    ? cutlist_large(
	maximum = start(m), 
	minimum = cutoff(m),
	step = sstep(m),
	spacing = spacing(m),
	space = north(p) - south(p),
	current = start(m)
    )
    : cutlist(
	maximum = start(m), 
	minimum = cutoff(m),
	step = sstep(m),
	spacing = spacing(m),
	space = north(p) - south(p),
	current = cutoff(m)
    );

module inner_stepped(p, m) {
    echo("stepped_mode = ", m);
    cutlist = get_cutlist(p, m);
    echo(cutlist);

    // lines get progressively smaller
    translate([west(p),north(p)-header(m)])
    square([east(p)-west(p),header(m)]);
    shrinking_step(p, m, cutlist, north(p)-header(m), len(cutlist) - 1);
}

module stepped_debug(p, m) {
    trim(p)
    debug(p, [
	str("start = ", start(m)),
	str("spacing = ", spacing(m)),
	str("step = ", sstep(m)),
	str("header = ", header(m)),
	str("cutoff = ", cutoff(m))
    ])
    inner_stepped(p, m);
    corners(p);
}

module stepped_back(p, m=large_mode) {
    trim(p)
    inner_stepped(mirror_paper(p), m);
    corners(p);
}

module stepped(p, m=large_mode) {
    trim(p)
    inner_stepped(p, m);
    corners(p);
}

paper = lihit_a5();
stepped_debug(paper, large_mode);
