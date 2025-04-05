# quick and dirty rendering script
set -exuo pipefail

openscad-render dotted_paper.scad

color=${1:-#f0f0f0}

# pkg librsvg

for input in $( find ./output/ | grep 'svg$'); do
	output=${input//svg/pdf}
	sed -i 's/stroke="black"//g' "$input"
	sed -i "s/lightgray/$color/g" "$input"
	rsvg-convert -f pdf -o "$output" "$input"
	rm "$input"
done

