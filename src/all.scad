include <bars.scad>;
include <paper.scad>;
// NOPREVIEW

// RENDER svg
module bars_a5_5mm_debug() {
    bars_debug(lihit_a5(), "5.0");
};

// 5.0 =========================================

// RENDER svg
module bars_a5_5mm() {
    bars(lihit_a5(), "5.0");
};

// RENDER svg
module bars_a5_5mm_back() {
    bars(mirror_paper(lihit_a5()), "5.0");
};

// 4.0 =========================================

// RENDER svg
module bars_a5_4() {
    bars(lihit_a5(4), "4.0");
};

// RENDER svg
module bars_a5_4mm_back() {
    bars(mirror_paper(lihit_a5(4)), "4.0");
};

// 3.5 =========================================

// RENDER svg
module bars_a5_3o5mm() {
    bars(lihit_a5(3.5), "3.5");
};

// RENDER svg
module bars_a5_3o5mm_back() {
    bars(mirror_paper(lihit_a5(3.5)), "3.5");
};

// 3.0 =========================================

// RENDER svg
module bars_a5_3mm() {
    bars(lihit_a5(3), "3.0");
};

// RENDER svg
module bars_a5_3mm_back() {
    bars(mirror_paper(lihit_a5(3)), "3.0");
};

// 2.5 =========================================

// RENDER svg
module bars_a5_2o5mm() {
    bars(lihit_a5(2.5), "2.5");
};

// RENDER svg
module bars_a5_2o5mm_back() {
    bars(mirror_paper(lihit_a5(2.5)), "2.5");
};
