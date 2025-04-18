include <bars.scad>;
// NOPREVIEW

// RENDER svg
module bars_a5_5mm_debug() {
    bars_debug(lihit_a5_5mm_1o5x(ends="line"));
};

// RENDER svg
module bars_a5_5mm() {
    bars(lihit_a5_5mm_1o5x(ends="line"));
};
