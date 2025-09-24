# Image manipulation functions.
# Requires ImageMagick to be installed.
# On macOS: brew install imagemagick
# On Debian/Ubuntu: sudo apt-get install imagemagick

# Get image dimensions (width and height).
# Usage: imgsize <image_file>
imgsize() {
	identify -format "%w %h\n" "$1"
}

# Rotate an image.
# Usage: imgrotate <source_image> [degrees] [destination_image]
# Default degrees: 90
# Default destination: overwrites source
imgrotate() {
	local src="$1"
	local val="${2:-90}"
	local dst="${3:-$src}"
	convert -rotate "$val" "$src" "$dst"
}

# Resize an image, creating a new file with a size suffix.
# Usage: imgresize <image_file> <size>
# Example: imgresize photo.jpg 50% -> photo_50%.jpg
# Example: imgresize photo.jpg 640x480 -> photo_640x480.jpg
imgresize() {
	local src="$1"
	local size="$2"
	local filename="${src%.*}"
	local extension="${src##*.}"
	local finalName="${filename}_${size}.${extension}"
	convert "$src" -quality 100 -resize "$size" "$finalName"
	echo "$finalName resized to $size"
}

# Resize an image in-place.
# Usage: imgresize_inplace <image_file> <size>
imgresize_inplace() {
	local src="$1"
	local size="$2"
	convert "$src" -quality 100 -resize "$size" "$src"
	echo "$src resized to $size"
}

# Resize all images with a given extension in the current directory.
# Usage: imgresizeall <extension> <size>
# Example: imgresizeall jpg 50%
imgresizeall() {
	for f in *.${1}; do
		imgresize "$f" "$2"
	done
}

# Resize all images with a given extension in-place in the current directory.
# Usage: imgresizeall_inplace <extension> <size>
# Example: imgresizeall_inplace jpg 50%
imgresizeall_inplace() {
	for f in *.${1}; do
		imgresize_inplace "$f" "$2"
	done
}

# Optimize an image for the web, creating a new file with "_optimized" suffix.
# Usage: imgoptimize <image_file>
imgoptimize() {
	local src="$1"
	local filename="${src%.*}"
	local extension="${src##*.}"
	local finalName="${filename}_optimized.${extension}"
	convert "$src" -strip -interlace Plane -quality 85% "$finalName"
	echo "$finalName created"
}

# Optimize an image for the web in-place.
# Usage: imgoptimize_inplace <image_file>
imgoptimize_inplace() {
	convert "$1" -strip -interlace Plane -quality 85% "$1"
	echo "$1 optimized"
}

# Optimize all images with a given extension in the current directory.
# Usage: imgoptimizeall <extension>
# Example: imgoptimizeall jpg
imgoptimizeall() {
	for f in *.${1}; do
		imgoptimize "$f"
	done
}

# Optimize all images with a given extension in-place in the current directory.
# Usage: imgoptimizeall_inplace <extension>
# Example: imgoptimizeall_inplace jpg
imgoptimizeall_inplace() {
	for f in *.${1}; do
		imgoptimize_inplace "$f"
	done
}

# Convert images to JPG format.
# Usage: img2jpg <image_file>...
img2jpg() {
	for f in "$@"; do
		local fn="${f%.*}"
		convert -quality 100 "$f" "${fn}.jpg"
	done
}

# Convert images to WebP format.
# This function uses cwebp which may need to be installed (`brew install webp`).
# It can provide better optimization than ImageMagick.
# Usage: img2webp <image_file>...
img2webp() {
	for f in "$@"; do
		local fn="${f%.*}"
		cwebp -q 100 "$f" -o "$(basename "${fn}").webp"
	done
}

# Convert SVG files to PNG format.
# Usage: svg2png <svg_file>...
svg2png() {
	for f in "$@"; do
		local fn="${f%.*}"
		# Using ImageMagick's convert is a common way to do this.
		convert "$f" "$fn.png"
	done
}
