function [] = fun_T_spec( length, T, steps )
    init_protein = generate_protein(length);
    [E, S, L, MCS_T, min_protein, ~] = fold_protein(init_protein, T, steps);
	save(strcat('S-', mat2str(protein_size(min_protein)), '_after_', mat2str(MCS_T), '_steps.mat'), 'E', 'S', 'L', 'min_protein');
end

