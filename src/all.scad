include <bars.scad>;
include <stepped.scad>;
include <paper.scad>;
include <corners.scad>;
include <dots.scad>;
include <lines.scad>;
include <grid.scad>;
include <table_of_contents.scad>;
// NOPREVIEW

// RENDER svg
module blank() {
    corners(lihit_a5());
}

// RENDER svg
module stepped_a5_back() {
    stepped(mirror_paper(lihit_a5()), small_mode);
}

// RENDER svg
module stepped_a5() {
    stepped(lihit_a5(), small_mode);
}

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

// 2.0 =========================================

// RENDER svg
module bars_a5_2mm() {
    bars(lihit_a5(2), "2.0");
};

// RENDER svg
module bars_a5_2mm_back() {
    bars(mirror_paper(lihit_a5(2)), "2.0");
};


// 1.5 =========================================

// RENDER svg
module bars_a5_1o5mm() {
    bars(lihit_a5(1.5), "1.5");
};

// RENDER svg
module bars_a5_1o5mm_back() {
    bars(mirror_paper(lihit_a5(1.5)), "1.5");
};


// Table of contents ==========================

// RENDER svg
module toc_a5_3o5mm() {
    toc(lihit_a5(3.5), "3.5");
};

