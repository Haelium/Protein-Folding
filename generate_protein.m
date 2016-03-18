function [protein] = generate_protein(protein_length, monomer_number)
% Initialises a datastructrure to represent a protein
% Protein is represented by a vector of triples representing x and y
% coordinates with an enumerated type to represent the monomer
    rng('shuffle');
    % generate 1 dimensional array of length "protein_length"
    % each element of the array is selected randomly from 1:monomer_number
    A = randi(monomer_number, 1, protein_length);
    % Initial x and y coordinates for protein
    x_offset = 5;
    y_offset = 15;
    init_x = x_offset : (protein_length + x_offset - 1);
    init_y = ones(1,protein_length) * y_offset;
    
    % concatenate A with x and y coordinates to generate a protein
    % represented as an array of monomers with associated coordinates
    protein = cat(1, A, init_x, init_y);

end
