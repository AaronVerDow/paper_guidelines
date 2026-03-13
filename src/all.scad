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
module half_lines_a5_5mm() {
    lines(lihit_a5(ends="space"));
}

// RENDER svg
module lines_a5_5mm() {
    lines(lihit_a5(line=0, ends="space"));
}

// RENDER svg
module half_dots_a5_5mm() {
    dots(lihit_a5(ends="space"), dot_options());
}

// RENDER svg
module dots_a5_5mm() {
    dots(lihit_a5(line=0, ends="space"), dot_options());
}

// RENDER svg
module grid_a5_5mm() {
    grid(lihit_a5(line=0, ends="space"), grid_options(label="5.0"));
}

// RENDER svg
module grid_a5_3mm() {
    grid(lihit_a5(3, line=0, ends="space"), grid_options(grid=3, label="3.0"));
}

// RENDER svg
module grid_a5_5mm_debug() {
    grid_debug(lihit_a5(ends="space"), grid_options());
}

// RENDER svg
module stepped_a5_small_back() {
    stepped(mirror_paper(lihit_a5()), small_mode);
}

// RENDER svg
module stepped_a5_small() {
    stepped(lihit_a5(), small_mode);
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

