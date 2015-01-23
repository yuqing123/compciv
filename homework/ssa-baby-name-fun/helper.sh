mkdir -p data-hold/names-by-state
curl -o namesbystate.zip http://stash.compciv.org/ssa_baby_names/namesbystate.zip
unzip namesbystate.zip
cd ..
mkdir -p names-nationwide
curl -o names.zip http://stash.compciv.org/ssa_baby_names/names.zip
unzip names.zip
