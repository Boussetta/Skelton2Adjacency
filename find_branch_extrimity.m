function [extrimity, weight] = find_branch_extrimity( cell,aug_skeleton, aug_nodes )
%FIND_BRANCH_EXTRIMITY Summary of this function goes here
%   Detailed explanation goes here
aug_skeleton(cell(1),cell(2)) = 0;
neighborhood = aug_skeleton(cell(1)-1:cell(1)+1,cell(2)-1:cell(2)+1);

[row, coll] = find(neighborhood(:,:) == 1); k = [row, coll] - ones(size([row, coll],1),1)*[2, 2];
branches = [row, coll] + ones(size([row, coll],1),1) * (cell - [2, 2]);

if size([row, coll],1) == 0
    %     disp('End point case');
    extrimity = cell;
    weight = 0;
    return
elseif size([row, coll],1) > 1
    %     disp('branch point case');
    for i = 1:size(branches,1)
        if strmatch(branches(i,:), aug_nodes) > 0
            extrimity = branches(i,:);
            weight = norm(k(i,:));
            return
        end
    end
else    
    cell = branches;
    if strmatch(cell, aug_nodes) > 0
        extrimity = cell;
        weight = norm(k(1,:));
        return
    end
end

[extrimity, w] = find_branch_extrimity( cell,aug_skeleton, aug_nodes );
weight = norm(k(1,:)) + w;
end

