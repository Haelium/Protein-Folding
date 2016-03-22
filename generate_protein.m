function [protein] = generate_protein(protein_length, monomer_number)
% Initialises a datastructrure to represent a protein
% Protein is represented by a vector of triples representing x and y
% coordinates with an enumerated type to represent the monomer
    rng('shuffle');
    % generate 1 dimensional array of length "protein_length"
    % each element of the array is selected randomly from 1:monomer_number
    A = randi(monomer_number, 1, protein_length);
    % Initial x and y coordinates for protein
    %x_offset = 5;
    %y_offset = 15;
    %z_offset = 15;
    init_x = ones(1, protein_length);
    init_y = ones(1, protein_length);
    init_z = ones(1, protein_length);
    init_x(1) = 5;
    init_y(1) = 5;
    init_z(1) = 5;
    for m = 2:protein_length
        switch randi(3)
            case 1
                init_x(m) = init_x(m - 1) + 1;
                init_y(m) = init_y(m - 1);
                init_z(m) = init_z(m - 1);
            case 2
                init_x(m) = init_x(m - 1);
                init_y(m) = init_y(m - 1) + 1;
                init_z(m) = init_z(m - 1);
            case 3
                init_x(m) = init_x(m - 1);
                init_y(m) = init_y(m - 1);
                init_z(m) = init_z(m - 1) + 1;
        end
    end
    % concatenate A with x and y coordinates to generate a protein
    % represented as an array of monomers with associated coordinates
    protein = cat(1, A, init_x, init_y, init_z);
end
