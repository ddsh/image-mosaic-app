function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H, dest_canvas_width_height)

% parameters initialization
width = dest_canvas_width_height(1);
height = dest_canvas_width_height(2);
result_img = zeros([height, width, 3]);
[H, W, ~] = size(src_img);
mask = zeros([height, width]);
% compute all the indices of the bg image
points = zeros(height*width,2);
c = 1;
for h = 1:height
    for w = 1:width
        points(c, :) = [w h];
        c = c + 1;
    end
end
% apply the inverse homography to the background image
new_points = applyHomography(resultToSrc_H, points);
% select the points that fit in the dimension of the source images
% and thus is construct the mask of the background
Xq = [];
Yq = [];
c = 1;
for h = 1:height
    for w = 1:width
        x = new_points(c, 1);
        y = new_points(c, 2);
        if 1 < y && y < H && 1 < x && x < W
            mask(h, w) = 1;
            Xq = [Xq,x];
            Yq = [Yq,y];
        end
        c = c + 1;
    end
end
% interpolate the new points
interpR = interp2(src_img(:, :, 1), Xq, Yq);
interpG = interp2(src_img(:, :, 2), Xq, Yq);
interpB = interp2(src_img(:, :, 3), Xq, Yq);
% add the interpolations to the result image
c = 1;
for h = 1:height
    for w = 1:width
        if mask(h, w) == 1
            result_img(h, w, 1) = interpR(c);
            result_img(h, w, 2) = interpG(c);
            result_img(h, w, 3) = interpB(c);
            c = c + 1;
        end
    end
end
