function [stretched] = check_stretch(protein, protein_length, link_number, x_new, y_new)
% Checks if a possible move will cause "stretching" in the protein chain
% bond length value should remain as 1
    stretched = false;
    
    % Test for inner links
    if (link_number > 1) && (link_number < protein_length)
        x_left = protein(2, link_number-1);
        y_left = protein(3, link_number-1);
        x_right = protein(2, link_number+1);
        y_right = protein(3, link_number+1);
        
        % record distances from neighbouring monomers 
        x_from_left = abs(x_new - x_left);
        x_from_right= abs(x_new - x_right);
        y_from_left = abs(y_new - y_left);
        y_from_right= abs(y_new - y_right);
    
        % If distance chosen location for monomer to move to is greater than 1
        % then there is a stretch
    
        if (x_from_left + y_from_left > 1) || (x_from_right + y_from_right > 1)
            stretched = true;
        end
        
    else    % test for outer links
        if link_number == protein_length    % rightmost protein
            x_nearest = protein(2, link_number -1);
            y_nearest = protein(3, link_number -1);
        else                                % leftmost protein
            x_nearest = protein(2, 2);
            y_nearest = protein(3, 2);  
        end
    
        x_dist = abs(x_new - x_nearest);
        y_dist = abs(y_new - y_nearest);
        
        if (x_dist + y_dist > 1)
            stretched = true;
        end
    end
end

