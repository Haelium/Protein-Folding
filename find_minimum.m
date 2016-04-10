function [min_E, min_S, min_L, MCS_T] = find_minimum( length, T, steps, J )
    init_protein = generate_protein(length);
    [~, ~, ~, MCS_T, min_protein, ~] = fold_protein(init_protein, T, steps, J);
    min_E = protein_energy(min_protein, J);
    min_S = protein_size(min_protein, J);
    min_L = length_end_to_end(min_protein);
end