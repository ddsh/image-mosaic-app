function stitched_img = stitchImg(varargin)

bg_img = varargin{1};
ransac_n = 3000; % Max number of iteractions
ransac_eps = 30; %Acceptable alignment error 

for iter = 2:3 
    portrait_img = varargin{iter};

    % Use RANSAC to compute the homography
    [xs, xd] = genSIFTMatches(portrait_img, bg_img);
    [inliers_id, H_3x3] = runRANSAC(xs, xd, ransac_n, ransac_eps);
    H = computeHomography(xs(inliers_id, :), xd(inliers_id, :));

    % Compute the translation
    tx = floor(.8*size(portrait_img, 2));
    T = [1 0 0; 0 1 0; 0 tx 1];
    H = H*T;

    %S = xs(inliers_id, :);
    %D = applyHomography(H, S);
    %showCorrespondence(portrait_img,bg_img, S, D);
    dest_canvas_width_height = [tx + size(bg_img, 2), size(bg_img, 1)];
    [mask, dest_img] = backwardWarpImg(portrait_img, inv(H), dest_canvas_width_height);

    % Superimpose the image
    bg = zeros(size(bg_img, 1), tx + size(bg_img, 2), 3);
    bg(:, 1+tx:end, :) = bg_img;
    bmask = zeros(size(bg_img, 1), tx + size(bg_img, 2));
    bmask(:, 1+tx:end) = ones(size(bg_img, 1), size(bg_img, 2));

    bg_img = blendImagePair(dest_img, mask, bg, bmask,'blend');
end
stitched_img = bg_img;