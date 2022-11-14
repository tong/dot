imgsize() {
    identify -format "%w %h" "$1"
    echo
}

imgrotate() {
    local src=$1
    local dst=$src
    local val=90
    if [ ! -z $2 ]; then; val=$2; fi
    if [ ! -z $3 ]; then; dst=$3; fi
 	convert -rotate $val "$src" "$dst"
    #echo "$src $val° $dst" 
}

# imgresize() {
#     local filename=${1%\.*}
#     local extension="${1##*.}"
#     local separator="_"
#     if [ ! -z $3 ]; then
#         local finalName="$filename.$extension"
#     else
#         local finalName="$filename$separator$2.$extension"
#     fi
#     convert $1 -quality 100 -resize $2 $finalName
#     echo "$finalName resized to $2"
# }
#
# imgresizeall() {
#     for f in *.${1}; do
#         if [ ! -z $3 ]; then
#             imgresize "$f" ${2} t
#         else
#             imgresize "$f" ${2}
#         fi
#     done
# }
#
# imgoptimize() {
#     local filename=${1%\.*}
#     local extension="${1##*.}"
#     local separator="_"
#     local suffix="optimized"
#     local finalName="$filename$separator$suffix.$extension"
#     convert $1 -strip -interlace Plane -quality 85% $finalName
#     echo "$finalName created"
# }
#
# Imgoptimize() {
#     local filename=${1%\.*}
#     local extension="${1##*.}"
#     local separator="_"
#     local suffix="optimized"
#     local convert $1 -strip -interlace Plane -quality 85% $1
#     echo "$1 created"
# }
#
# imgoptimizeall() {
#     for f in *.${1}; do
#         imgoptimize "$f"
#     done
# }
#
# Imgoptimizeall() {
#     for f in *.${1}; do
#         Imgoptimize "$f"
#     done
# }

img2jpg() {
    for f in "$@"; do
        local fn=${f%\.*}
        convert -quality 100 $f "${fn}.jpg"
    done
}

img2webp() {
    for f in "$@"; do
        local fn=${f%\.*}
        cwebp -q 100 $f -o $(basename ${fn}).webp
    done
}

svg2png() {
    for f in "$@"; do
        local fn=${f%\.*}
        inkscape -o "$fn.png" $f
    done
}
