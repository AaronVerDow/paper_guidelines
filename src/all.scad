include <bars.scad>;
include <paper.scad>;
// NOPREVIEW

// RENDER svg
module bars_a5_5mm_debug() {
    bars_debug(lihit_a5(), "1.5x 5.0");
};

// RENDER svg
module bars_a5_5mm() {
    bars(lihit_a5(), "1.5x 5.0");
};

// RENDER svg
module bars_a5_5mm_back() {
    bars(mirror_paper(lihit_a5()), "5.0 1.5x");
};


// RENDER svg
module bars_a5_2o5mm() {
    bars(lihit_a5(2.5), "1.5x 2.5");
};

// RENDER svg
module bars_a5_2o5mm_back() {
    bars(mirror_paper(lihit_a5(2.5)), "2.5 1.5x");
};

