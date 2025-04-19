include <bars.scad>;
include <challenge.scad>;
include <paper.scad>;
include <dots.scad>;
// NOPREVIEW

// RENDER svg
module half_dots_a5_5mm() {
    dots(lihit_a5(ends="space"), dot_options());
}

// RENDER svg
module dots_a5_5mm() {
    dots(lihit_a5(line=0, ends="space"), dot_options());
}

// RENDER svg
module challenge_a5() {
    challenge(lihit_a5());
}

// RENDER svg
module challenge_a5_back() {
    challenge(mirror_paper(lihit_a5()));
}

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
module bars_a5_4mm() {
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
