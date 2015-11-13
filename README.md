# ImageMosaicApp

From a set of images sharing common parts, compute a panorama.

1. Compute SIFT features and RANSAC to compute matching points.
2. Compute corresponding homographies.
3. Blend the new images.

Here is provided an example with three images: mountain_center, mountain_left, mountain_right

Usage: runImageMosaicApp()
