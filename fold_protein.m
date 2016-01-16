function [E_mean, L_mean, protein] = fold_protein(protein, T, J, number_of_runs)
% Folds a protein
%   Detailed explanation goes here

    % Initialisation block
    E_of_protein = zeros(1, number_of_runs);
    L_of_protein = zeros(1, number_of_runs);
    E_current = 0;
    protein_length = size(protein, 2);
    
    % Choose a link at random and see if it can be moved
    for step = 1:number_of_runs
        link_number = randi(protein_length);   % pick random monomer on chain
        direction = ceil(rand()*8);   % pick direction denoted by number from 1 to 8
            switch direction
            case 1          % RIGHT and UP
                x_new = protein(2, link_number)+1;
                y_new = protein(3, link_number)+1;
            case 2          % RIGHT and STATIC
                x_new = protein(2, link_number)+1;
                y_new = protein(3, link_number);
            case 3          % RIGHT and DOWN
                x_new = protein(2, link_number)+1;
                y_new = protein(3, link_number)-1;
            case 4          % STATIC and DOWN
                x_new = protein(2, link_number);
                y_new = protein(3, link_number)-1;
            case 5          % LEFT and DOWN
                x_new = protein(2, link_number)-1;
                y_new = protein(3, link_number)-1;
            case 6          % LEFT and STATIC
                x_new = protein(2, link_number)-1;
                y_new = protein(3, link_number);
            case 7          % LEFT and UP
                x_new = protein(2, link_number)-1;
                y_new = protein(3, link_number)+1;
                otherwise	% STATIC and UP
                x_new = protein(2, link_number);
                y_new = protein(3, link_number)+1;
            end
        % check if chosen location is occupied
        occupied = site_occupied(x_new, y_new, protein);
        % check if chosen location causes "stretch"
        stretched = check_stretch(protein, protein_length, link_number, x_new, y_new);
        % if chosen location not occupied, create copy of protein with new
        % shape
        if ~occupied && ~stretched
            copy_protein = protein;
            copy_protein(2, link_number) = x_new;
            copy_protein(3, link_number) = y_new;
            % Compare energy value of new protein shape with the old shape
            E_after_move = protein_energy(copy_protein, J, protein_length);
            E_current = protein_energy(protein, J, protein_length);
            delta_E = E_after_move - E_current;

            if delta_E <= 0  % If energy decreases, always move
                protein = copy_protein;
                E_current = E_after_move;
            else    % If delta_E is positive, the change will cost energy, is only 
                    % made if the following statistical condition is met
                boltzmann_factor = exp(-delta_E / T);
                if boltzmann_factor > rand
                    protein = copy_protein;
                    E_current = E_after_move;
                end
            end
        end
        E_of_protein(step) = E_current;
        L_of_protein(step) = length_end_to_end(protein, protein_length);
    end
    
    E_mean = mean(E_of_protein);
    L_mean = mean(L_of_protein);

end

