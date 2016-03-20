function [ protein ] = propose_move( protein )
%PROPOSE_MOVE Summary of this function goes here
%   Detailed explanation goes here
    old_protein = protein;
    protein_length = size(protein, 2);
    link_number = randi(protein_length);   % pick random monomer on chain
    if (link_number == 1 || link_number == protein_length)  % Monomers at end of chain
        if (link_number == 1)
            n = 2;
        else
            n = protein_length - 1;
        end
        direction = ceil(rand()*6);
        switch direction
        case 1
            x_new = protein(2, n) + 1;
            y_new = protein(3, n);
            z_new = protein(4, n);
        case 2
            x_new = protein(2, n) - 1;
            y_new = protein(3, n);
            z_new = protein(4, n);
        case 3
            x_new = protein(2, n);
            y_new = protein(3, n) + 1;
            z_new = protein(4, n);
        case 4
            x_new = protein(2, n);
            y_new = protein(3, n) - 1;
            z_new = protein(4, n);
        case 5
            x_new = protein(2, n);
            y_new = protein(3, n);
            z_new = protein(4, n) + 1;
        case 6
            x_new = protein(2, n);
            y_new = protein(3, n);
            z_new = protein(4, n) - 1;
        end
    else
        n = link_number;
        x_new = protein(2, n);
        y_new = protein(3, n);
        z_new = protein(4, n);
        switch ceil(rand()*8);
        case 1
            if ((protein(2, n)) == protein(2, n + 1)) && (protein(3, n) == protein(3, n - 1))
                x_new = protein(2, n - 1);
                y_new = protein(3, n + 1);
                z_new = protein(4, n);
            end
        case 2
            if ((protein(2, n)) == protein(2, n - 1)) && (protein(3, n) == protein(3, n + 1))
                x_new = protein(2, n + 1);
                y_new = protein(3, n - 1);
                z_new = protein(4, n);
            end
        case 3
            if ((protein(4, n)) == protein(4, n + 1)) && (protein(2, n) == protein(2, n - 1))
                x_new = protein(2, n + 1);
                y_new = protein(3, n);
                z_new = protein(4, n - 1);
            end
        case 4
            if ((protein(4, n)) == protein(4, n - 1)) && (protein(2, n) == protein(2, n + 1))
                x_new = protein(2, n - 1);
                y_new = protein(3, n);
                z_new = protein(4, n + 1);
            end
        case 5
            if ((protein(4, n)) == protein(4, n + 1)) && (protein(3, n) == protein(3, n - 1))
                x_new = protein(2, n);
                y_new = protein(3, n + 1);
                z_new = protein(4, n - 1);
            end
        case 6
            if ((protein(4, n)) == protein(4, n - 1)) && (protein(3, n) == protein(3, n + 1))
                x_new = protein(2, n);
                y_new = protein(3, n - 1);
                z_new = protein(4, n + 1);
            end
        end
    end
    if ~check_stretch(protein, protein_length, link_number, x_new, y_new, z_new) && ~site_occupied(x_new, y_new, z_new, protein)
        protein(2, link_number) = x_new;
        protein(3, link_number) = y_new;
        protein(4, link_number) = z_new;
    end
end

