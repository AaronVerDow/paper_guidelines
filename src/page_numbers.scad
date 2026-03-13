// NOPREVIEW
module page_numbers(p) {
    digits=4;
    line=0.3;
    size=2.5;
    y=2.5;
    x=y*0.65;
    delta=line+x;
    total_x=digits*delta+line;
    total_y=y+line*2;
    //center
    //translate([(east(p)-west(p))/2+west(p),south(p)/2])

    module page_number_boxes(p) {
	translate([-total_x,-total_y*2])
	difference() {
	    square([digits*delta+line,y+line*2]);
	    for(n=[0:1:digits-1]) {
	    translate([line+delta*n,line])
	    square([x,y]);
	    }
	}
    }
    if (numbered(p)) {
	if (back(p)) {
	    translate([west(p)+total_x,south(p)])
	    page_number_boxes(p);
	} else {
	    translate([east(p),south(p)])
	    page_number_boxes(p);
	}
    }
}
