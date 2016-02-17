function [E_of_protein, L_of_protein, protein] = fold_protein(protein, T, J, number_of_runs)
% Folds a protein
%   Finds a legal, randomly selected monomer move, calculates energy
%   beforee and after the move. Then the decision is made whether to make 
%   the move or not based on those energy levels.

    % Initialisation block
    E_of_protein = zeros(1, number_of_runs);
    L_of_protein = zeros(1, number_of_runs);
    E_current = 0;
    protein_length = size(protein, 2);
    
    % Choose a link at random and see if it can be moved
    for step = 1:number_of_runs
        % Choose legal move
            link_number = randi(protein_length);   % pick random monomer on chain
            direction = ceil(rand()*4);   % pick direction denoted by number from 1 to 8
            switch direction
                case 1          % RIGHT and UP
                x_new = protein(2, link_number)+1;
                y_new = protein(3, link_number)+1;
                case 2          % RIGHT and DOWN
                x_new = protein(2, link_number)+1;
                y_new = protein(3, link_number)-1;
                case 3          % LEFT and DOWN
                x_new = protein(2, link_number)-1;
                y_new = protein(3, link_number)-1;
                case 4          % LEFT and UP
                x_new = protein(2, link_number)-1;
                y_new = protein(3, link_number)+1;
                otherwise
            end
            % check if chosen location is occupied
            occupied = site_occupied(x_new, y_new, protein);
            % check if chosen location causes "stretch"
            stretched = check_stretch(protein, protein_length, link_number, x_new, y_new);
        
        if ~occupied && ~stretched
        % After finding legal move, make protein with that move and compare
        % energy levels
        copy_protein = protein;
        copy_protein(2, link_number) = x_new;
        copy_protein(3, link_number) = y_new;
        % Compare energy value of new protein shape with the old shape
        E_after_move = protein_energy(copy_protein, J, protein_length);
        E_current = protein_energy(protein, J, protein_length);
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
        %plot(protein(2,:), protein(3,:));
        %axis([0 120 0 120]);
        %drawnow;
        E_of_protein(step) = E_current;
        L_of_protein(step) = length_end_to_end(protein, protein_length);
    end
end

