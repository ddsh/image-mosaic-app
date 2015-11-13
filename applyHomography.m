function dest_pts_nx2 = applyHomography(H_3x3, src_pts_nx2)

%  computing the homogeneous coordinates
[N, ~] = size(src_pts_nx2);
points = ones(N, 3);
points(:, 1) = src_pts_nx2(:,2);
points(:, 2) = src_pts_nx2(:,1);
dest_pts_nx2 = zeros(N, 2);

% applying the transformation
dest_points = points * H_3x3;

% normalizing the results
dest_points(:, 1)  = dest_points(:, 1) ./ dest_points(:, 3);  
dest_points(:, 2) = dest_points(:, 2) ./ dest_points(:, 3);  

dest_pts_nx2(:,1) = dest_points(:, 2);
dest_pts_nx2(:,2) = dest_points(:, 1);
