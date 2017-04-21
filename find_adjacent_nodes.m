function [adjacent_nodes, weight] = find_adjacent_nodes( cell,aug_skeleton, aug_nodes)
%FIND_ADJACENT_NODES Summary of this function goes here
%   Detailed explanation goes here
aug_skeleton(cell(1),cell(2)) = 0;
neighborhood = aug_skeleton(cell(1)-1:cell(1)+1,cell(2)-1:cell(2)+1);

[row, coll] = find(neighborhood(:,:) == 1); k = [row, coll] - ones(size([row, coll],1),1)*[2, 2]; 
branches = [row, coll] + ones(size([row, coll],1),1) * (cell - [2, 2]);

adjacent_nodes = zeros(size(branches,1),2);
weight = zeros(size(branches,1),1);

for i = 1:size(branches,1)
    cell = branches(i,:); 
    tmp = aug_skeleton;
    for j = 1:size(branches,1)
        if ~isequal(i,j)
            tmp(branches(j,1),branches(j,2)) = 0;
        end
    end
    [extrimity, w] = find_branch_extrimity(cell,tmp, aug_nodes);
    adjacent_nodes(i,:) = extrimity(:,:);
    weight(i,:) = w + norm(k(i,:));
end

end

