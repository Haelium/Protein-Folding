J = normrnd(-3, 0, 20);
T = 1;
protein_length = 27;
number_of_runs = 5*10^6;
init_protein = generate_protein(protein_length);
[E, S, L, MCS_T, min_protein, final_protein] = fold_protein(init_protein, T, number_of_runs, J);
filename = strcat('S-', mat2str(protein_size(min_protein,J)), '_after_', mat2str(MCS_T), '_steps.mat');
save(filename, 'E', 'S', 'L', 'min_protein');