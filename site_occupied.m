function [occupied] = site_occupied(x, y, protein)
% Returns true if site occupied by monomer, takes coordinates as input
%   Checks if x and y coord input match any x & y coord of monomer in input
%   protein chain

    % ismember function returns matrix of boolean values, 1 at each position
    % of first input argument with a value that matches the second argument
    match_x = ismember(protein(2,:), x);
    match_y = ismember(protein(3,:), y);

    % anding the two matrices will result in a matrix of all 0s unless
    % a momomer of the protein already occupies the x and y coordinates
    occupied = any(match_x & match_y);
end
