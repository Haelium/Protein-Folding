function [E_of_protein, L_of_protein, protein] = fold_protein(protein, T, metro_steps)
% Folds a protein
%   Finds a legal, randomly selected monomer move, calculates energy
%   beforee and after the move. Then the decision is made whether to make 
%   the move or not based on those energy levels.

    rng(1)
    % Initialisation block
    E_of_protein = zeros(1, metro_steps);
    L_of_protein = zeros(1, metro_steps);
    protein_length = size(protein, 2);
    E_current = pro_energy(protein);
    
    % Choose a link at random and see if it can be moved
    for step = 1:metro_steps
        % Choose legal move
            copy_protein = propose_move(protein);
            
            E_after_move = pro_energy(copy_protein);
            E_current = pro_energy(protein);

            delta_E = E_after_move - E_current;

            if delta_E < 0  % If energy decreases, always move
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
        
        %plot3(protein(2,:), protein(3,:), protein(4,:), '-r', 'Marker', '.', 'MarkerEdgeColor', 'b', 'MarkerSize', 8);
        %axis([0 35 0 35 0 35]);
        %drawnow;
        E_of_protein(step) = E_current;
        L_of_protein(step) = length_end_to_end(protein, protein_length);
    end
end
