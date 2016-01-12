function [protein] = generate_protein(protein_length)
% Initialises a datastructrure to represent a protein
% Protein is represented by a set of triples representing x and y coordinates with type of amino acid
    
    A = randi(1, 1, protein_length);
    % Initial x and y coordinates for protein
    x_offset = 10;
    y_offset = 15;
    init_x = x_offset : protein_length + 9;
    init_y = ones(1,protein_length) * y_offset;
    
    % first argument is dimension of 1
    protein = cat(1, A, init_x, init_y);

end
