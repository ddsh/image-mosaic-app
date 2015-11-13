function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode)

out_img = single(zeros(size(wrapped_imgs)));
Ms = im2single(masks);
Md = im2single(maskd);

if isequal(mode, 'overlay')
    real_Ms = Ms - Ms .* Md;
    real_Md = Md;
    img_s = im2single(wrapped_imgs).*cat(3, real_Ms, real_Ms, real_Ms);
    img_d = im2single(wrapped_imgd).*cat(3, real_Md, real_Md, real_Md);
elseif isequal(mode, 'blend')
    % Geometric differences
    Ms1 = Ms - Ms .* Md;
    Md1 = Md - Ms .* Md;
    % Compute the eurclidiean distance only on the point of interest
    BWs = bwdist(Ms1).*single(Ms);    
    BWd = bwdist(Md1).*single(Md);
    % Scale the results
    BWs = BWs / max(max(BWs));
    BWd = BWd / max(max(BWd));
    % Construct the final masks
    real_Ms = single(Ms) - BWs;
    real_Md = single(Md) - BWd;
    sum_mask = (real_Ms + real_Md);
    real_Ms = real_Ms ./ sum_mask;
    real_Md = real_Md ./ sum_mask;
    real_Ms(isnan(real_Ms)) = 0;
    real_Md(isnan(real_Md)) = 0;    
    img_s = im2single(wrapped_imgs).*cat(3, real_Ms, real_Ms, real_Ms);
    img_d = im2single(wrapped_imgd).*cat(3, real_Md, real_Md, real_Md);
end
   
out_img = out_img + img_s ;
out_img = out_img + img_d ;
