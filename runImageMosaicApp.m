function runImageMosaicApp()

% Usage:
% runImageMosaicApp()

% stitch three images
imgl = im2single(imread('mountain_left.png'));
imgc = im2single(imread('mountain_center.png'));
imgr = im2single(imread('mountain_right.png'));

% You are free to change the order of input arguments
stitched_img = stitchImg(imgr, imgc, imgl);
figure, imshow(stitched_img);
imwrite(stitched_img, 'mountain_panorama.png');
