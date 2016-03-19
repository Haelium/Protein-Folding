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
        %step
            link_number = randi(protein_length);   % pick random monomer on chain
            direction = ceil(rand()*12);   % pick direction denoted by number from 1 to 12
            switch direction
                case 1          % RIGHT and UP
                    x_new = protein(2, link_number) + 1;
                    y_new = protein(3, link_number) + 1;
                    z_new = protein(4, link_number);
                case 2          % RIGHT and DOWN
                    x_new = protein(2, link_number) + 1;
                    y_new = protein(3, link_number) - 1;
                    z_new = protein(4, link_number);
                case 3          % LEFT and DOWN
                    x_new = protein(2, link_number) - 1;
                    y_new = protein(3, link_number) - 1;
                    z_new = protein(4, link_number);
                case 4          % LEFT and UP
                    x_new = protein(2, link_number) - 1;
                    y_new = protein(3, link_number) + 1;
                    z_new = protein(4, link_number);
                case 5          % FORWARD and UP
                    x_new = protein(2, link_number);
                    y_new = protein(3, link_number) + 1;
                    z_new = protein(4, link_number) + 1;
                case 6          % FORWARD and DOWN
                    x_new = protein(2, link_number);
                    y_new = protein(3, link_number) - 1;
                    z_new = protein(4, link_number) + 1;
                case 7          % FORWARD and RIGHT
                    x_new = protein(2, link_number) + 1;
                    y_new = protein(3, link_number);
                    z_new = protein(4, link_number) + 1;
                case 8          % FORWARD and LEFT
                    x_new = protein(2, link_number) - 1;
                    y_new = protein(3, link_number);
                    z_new = protein(4, link_number) + 1;
                case 9          % BACKWARD and UP
                    x_new = protein(2, link_number);
                    y_new = protein(3, link_number) + 1;
                    z_new = protein(4, link_number) - 1;
                case 10          % BACKWARDD and DOWN
                    x_new = protein(2, link_number);
                    y_new = protein(3, link_number) - 1;
                    z_new = protein(4, link_number) - 1;
                case 11         % BACKWARD and RIGHT
                    x_new = protein(2, link_number) + 1;
                    y_new = protein(3, link_number);
                    z_new = protein(4, link_number) - 1;
                case 12         % BACKWARD and LEFT
                    x_new = protein(2, link_number) - 1;
                    y_new = protein(3, link_number);
                    z_new = protein(4, link_number) - 1;
            end
            % check if chosen location is occupied
            occupied = site_occupied(x_new, y_new, z_new, protein);
            % check if chosen location causes "stretch"
            stretched = check_stretch(protein, protein_length, link_number, x_new, y_new, z_new);
        
        if ~occupied && ~stretched
            % After finding legal move, make protein with that move and compare
            % energy levels
            copy_protein = protein;
            copy_protein(2, link_number) = x_new;
            copy_protein(3, link_number) = y_new;
            copy_protein(4, link_number) = z_new;
            % Compare energy value of new protein shape with the old shape
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
        end
        
        E_of_protein(step) = E_current;
        L_of_protein(step) = length_end_to_end(protein, protein_length);
    end
end

