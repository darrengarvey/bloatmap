#!/bin/bash -e

binary_or_lib="$1"
well_known_name="$(basename $binary_or_lib)"
mode="${2-syms}"
prefix="$PREFIX"
where_am_i="$(dirname $(readlink -f "$0"))"

scratchdir=/tmp/$(basename $0).$$
mkdir $scratchdir

nm -C -S -l "$binary_or_lib" > $scratchdir/nm.out
objdump -h "$binary_or_lib" > $scratchdir/objdump.out

./bloat/bloat.py \
    --strip-prefix="$prefix" \
    --nm-output=$scratchdir/nm.out \
    --objdump-output=$scratchdir/objdump.out \
    "$mode" \
> $scratchdir/${well_known_name}-data.json

cat <<-EOF > $scratchdir/${well_known_name}-index.html

<!DOCTYPE html>
<title>webtreemap for ${well_known_name}</title>
<script src="${scratchdir}/${well_known_name}-data.json"></script>
<link rel=stylesheet href="${where_am_i}/webtreemap/webtreemap.css">
<style>
body {
  font-family: sans-serif;
  font-size: 0.8em;
  margin: 2ex 4ex;
}

h1 {
  font-weight: normal;
}

#map {
  width: 1024px;
  height: 800px;

  position: relative;
  cursor: pointer;
  -webkit-user-select: none;
}
</style>

<h1>webtreemap for ${well_known_name}</h1>

<p>Click on a box to zoom in.  Click on the outermost box to zoom out.</p>

<div id='map'></div>

<script src="${where_am_i}/webtreemap/webtreemap.js"></script>

<script>
var map = document.getElementById('map');
appendTreemap(map, kTree);
</script>

EOF

echo "Generating webpage: ${scratchdir}/${well_known_name}-index.html"
gnome-open ${scratchdir}/${well_known_name}-index.html

