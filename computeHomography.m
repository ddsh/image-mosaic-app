function H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2)

[N, ~] = size(src_pts_nx2);
A = zeros([2*N, 9]);

% Compute the A matrix
for n = 1:N
    y_s = src_pts_nx2(n, 1);
    x_s = src_pts_nx2(n, 2);
    y_d = dest_pts_nx2(n, 1);
    x_d = dest_pts_nx2(n, 2);
    A(2*n-1, :) = [x_s, y_s, 1, 0, 0, 0, -x_d*x_s, -x_d*y_s -x_d];
    A(2*n, :) = [0, 0, 0, x_s, y_s, 1, -y_d*x_s, -y_d*y_s -y_d];
end

% Get the eigenvector for the smallest eigenvalue and reshape
[V, ~] = eig(A'*A);
H_3x3 = reshape(V(:,1), [3 3]);
