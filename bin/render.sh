# quick and dirty rendering script
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"

(
	cd "$REPO_ROOT/src/"
	openscad-render all.scad
)

color=${1:-black}
#color=${1:-#f0f0f0}

# pkg librsvg

for input in $( find "$REPO_ROOT/src/output/" | grep 'svg$'); do
	output=${input//svg/pdf}
	thumbnail="../media/$( basename "$output" | sed 's/pdf$/png/' )"
	sed -i 's/stroke="black"//g' "$input"
	sed -i "s/lightgray/$color/g" "$input"
	rsvg-convert -f pdf -o "$output" "$input"
	magick -background white "$output" -flatten "$thumbnail"
	rm "$input"
done

