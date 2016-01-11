function [protein] = generate_protein(protein_length)
% Initialises a datastructrure to represent a protein
% Protein datastructure is a 2 dimensional array of monomers

    dims = 1;   % 1 represents a monomer, 0 no monomer
    
    A = randi(1, 1, protein_length);
    % Initial x and y coordinates for protein
    x_offset = 10;
    y_offset = 15;
    init_x = x_offset : protein_length + 9;
    init_y = ones(1,protein_length) * y_offset;
    
    protein = cat(dims, A, init_x, init_y);

end