function [ total_energy ] = protein_energy(protein, J, protein_length)
% monomers to the total energy of the protein
% total_energy = sum of energy of attraction between all neighbouring
% monomers in the protein
    
    total_energy = 0;
    
    for monomer_num = 1:protein_length
        x_neighbour = protein(2, monomer_num)+1;
        y_neighbour = protein(3, monomer_num);
        energy = monomer_interaction_energy(x_neighbour, y_neighbour, protein, monomer_num, J); % This will check if
        % occupied and if so, calculate the interaction energy
        total_energy = total_energy + energy;        
          
        %choose neighbour below
        x_neighbour = protein(2, monomer_num);
        y_neighbour = protein(3, monomer_num)-1;
        energy = monomer_interaction_energy (x_neighbour, y_neighbour, protein, monomer_num, J); % This will check if
        % occupied and if so, calculate the interaction energy
        total_energy = total_energy + energy;       
        
        % choose neighbour  left
        x_neighbour = protein(2, monomer_num)-1;
        y_neighbour = protein(3, monomer_num);
        energy = monomer_interaction_energy (x_neighbour, y_neighbour, protein, monomer_num, J); % This will check if
        % occupied and if so, calculate the interaction energy
        total_energy=total_energy+energy;        
        
        % direction must be above
        x_neighbour = protein(2, monomer_num);
        y_neighbour = protein(3, monomer_num)+1;
        energy = monomer_interaction_energy (x_neighbour, y_neighbour, protein, monomer_num, J); % This will check if
        % occupied and if so, calculate the interaction energy
        total_energy=total_energy+energy;
    end

end

