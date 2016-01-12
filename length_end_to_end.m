function [length] = length_end_to_end(protein, protein_length)
    % This function measures the distance between the first and last
    % monomers on the protein
    x_2 = protein(2, 1);
    y_2 = protein(3, 1);
    x_1 = protein(2, protein_length);
    y_1 = protein(3, protein_length);
    length = sqrt((x_2 - x_1)^2 + (y_2 - y_1)^2);   
end