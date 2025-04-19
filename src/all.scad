include <bars.scad>;
include <paper.scad>;
// NOPREVIEW

// RENDER svg
module bars_a5_5mm_debug() {
    bars_debug(lihit_a5_5mm_1o5x(ends="line", "1.5x 5.0"));
};


// RENDER svg
module bars_a5_5mm() {
    bars(lihit_a5_5mm_1o5x(ends="line"), "1.5x 5.0");
};

// RENDER svg
module bars_a5_5mm_back() {
    bars(mirror_paper(lihit_a5_5mm_1o5x(ends="line")));
};

lihit_a5_2o5mm = lihit_a5(2.5, 2.5/2, "line");

// RENDER svg
module bars_a5_2o5mm() {
    bars(lihit_a5_2o5mm, "1.5x 2.5");
};

// RENDER svg
module bars_a5_2o5mm_back() {
    bars(mirror_paper(lihit_a5_2o5mm));
};

