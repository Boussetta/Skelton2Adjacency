function adjacency = skeleton2adjacency( skeleton )
%SKELETON2ADJACENCY Summary of this function goes here
% Find branch points of skeleton
branchImg = bwmorph(skeleton, 'branchpoints');
[row, column] = find(branchImg);
branchPts     = [row column];

endImg    = bwmorph(skeleton, 'endpoints');
[row, column] = find(endImg);
endPts        = [row column];

% Initialise adjacency matrix

nodes = [endPts;branchPts];
adjacency = zeros(size(nodes,1));

% We work on an augmented skeleton and nodes
aug_skeleton = [zeros(1,size(skeleton,2)+2); zeros(size(skeleton,1),1) skeleton zeros(size(skeleton,1),1);zeros(1,size(skeleton,2)+2)];
aug_nodes = nodes + ones(size(nodes,1),2);

for i = 1:size(aug_nodes,1)
    cell = aug_nodes(i,:);
    [adjacent_node, weight] = find_adjacent_nodes( cell,aug_skeleton, aug_nodes);
    for j = 1:size(adjacent_node,1);
        index = strmatch(adjacent_node(j,:), aug_nodes);
        adjacency(i,index) = weight(j);
    end
end

adjacency = (adjacency + adjacency')/2;

end

