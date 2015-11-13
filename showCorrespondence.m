function result_img = ...
    showCorrespondence(orig_img, warped_img, src_pts_nx2, dest_pts_nx2)

fh = figure;
[~, N, ~] = size(orig_img);
[n, ~] = size(src_pts_nx2);

% Display the two images aside
collage_1x2 = [orig_img, warped_img];
imshow(collage_1x2)

% Draw lines on the image
for i = 1:n
    line([src_pts_nx2(i, 1), N+dest_pts_nx2(i, 1)],...
         [src_pts_nx2(i, 2), dest_pts_nx2(i, 2)],...
         'LineWidth',1.5, 'Color', [1, 0, 0]);
end

result_img = saveAnnotatedImg(fh);