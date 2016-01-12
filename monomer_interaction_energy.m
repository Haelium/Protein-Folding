function [energy] = monomer_interaction_energy(x_neighbour, y_neighbour, protein, monomer_num, J)
% Calculates the interaction energy between a monomer in a protein and a
% neighbouring monomer if the neighbouring monomer exists. If the input
% coordinates of a potential neighbour do not corrospond to an existing
% monomer, return 0
    energy = 0;
    if site_occupied(x_neighbour, y_neighbour, protein)
        neighbour = intersect(find(protein(2,:) == x_neighbour), find(protein(3,:) == y_neighbour));
        % The interaction energy is only an issue for monomers which are
        % not linked on the protein chain
        if abs(neighbour - monomer_num) > 1
            % Use J matrix to find interaction energy between the two
            % monomers on the chain
            energy = J(protein(1, monomer_num), protein(1, neighbour));
        end
    end
end

