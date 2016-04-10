function [ protein ] = propose_move( protein )
%PROPOSE_MOVE Summary of this function goes here
%   Detailed explanation goes here
    distance = @(protein, n1, n2) sqrt((protein(2,n1) - protein(2,n2))^2 + (protein(3,n1) - protein(3,n2))^2 + (protein(4,n1) - protein(4,n2))^2);
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
    % Crankshaft moves start
    elseif (link_number + 2 <= protein_length) && (distance(protein, link_number - 1, link_number + 2) == 1)
        if (protein(2, link_number - 1) ~= protein(2, link_number + 2))
            x_new = protein(2, link_number - 1);
            x_new2= protein(2, link_number + 2);
            if (protein(3, link_number) == protein(3, link_number - 1))
                z_new = protein(4, link_number - 1);
                z_new2= protein(4, link_number + 2);
                if (rand > 0.5)
                    y_new = protein(3, link_number - 1) + 1;
                    y_new2= protein(3, link_number + 2) + 1;
                else
                    y_new = protein(3, link_number - 1) - 1;
                    y_new2= protein(3, link_number + 2) - 1;
                end
            elseif (protein(4, link_number) == protein(4, link_number - 1))
                y_new = protein(3, link_number - 1);
                y_new2= protein(3, link_number + 2);
                if (rand > 0.5)
                    z_new = protein(4, link_number - 1) + 1;
                    z_new2= protein(4, link_number + 2) + 1;
                else
                    z_new = protein(4, link_number - 1) - 1;
                    z_new2= protein(4, link_number + 2) - 1;
                end
            end
        elseif (protein(3, link_number - 1) ~= protein(3, link_number + 2))
            y_new = protein(3, link_number - 1);
            y_new2= protein(3, link_number + 2);
            if (protein(2, link_number) == protein(2, link_number - 1))
                z_new = protein(4, link_number - 1);
                z_new2= protein(4, link_number + 2);
                if (rand > 0.5)
                    x_new = protein(2, link_number - 1) + 1;
                    x_new2= protein(2, link_number + 2) + 1;
                else
                    x_new = protein(2, link_number - 1) - 1;
                    x_new2= protein(2, link_number + 2) - 1;
                end
            elseif (protein(4, link_number) == protein(4, link_number - 1))
                x_new = protein(2, link_number - 1);
                x_new2= protein(2, link_number + 2);
                if (rand > 0.5)
                    z_new = protein(4, link_number - 1) + 1;
                    z_new2= protein(4, link_number + 2) + 1;
                else
                    z_new = protein(4, link_number - 1) - 1;
                    z_new2= protein(4, link_number + 2) - 1;
                end
            end
        elseif (protein(4, link_number - 1) ~= protein(4, link_number + 2))
            z_new = protein(4, link_number - 1);
            z_new2= protein(4, link_number + 2);
            if (protein(2, link_number) == protein(2, link_number - 1))
                y_new = protein(3, link_number - 1);
                y_new2= protein(3, link_number + 2);
                if (rand > 0.5)
                    x_new = protein(2, link_number - 1) + 1;
                    x_new2= protein(2, link_number + 2) + 1;
                else
                    x_new = protein(2, link_number - 1) - 1;
                    x_new2= protein(2, link_number + 2) - 1;
                end
            elseif (protein(3, link_number) == protein(3, link_number - 1))
                x_new = protein(2, link_number - 1);
                x_new2= protein(2, link_number + 1);
                if (rand > 0.5)
                    y_new = protein(3, link_number - 1) + 1;
                    y_new2= protein(3, link_number + 2) + 1;
                else
                    y_new = protein(3, link_number - 1) - 1;
                    y_new2= protein(3, link_number + 2) - 1;
                end
            end
        end
    elseif (link_number - 2 > 0) && (distance(protein, link_number + 1, link_number - 2) == 1)
        if (protein(2, link_number + 1) ~= protein(2, link_number - 2))
            x_new = protein(2, link_number + 1);
            x_new2= protein(2, link_number - 2);
            if (protein(3, link_number) == protein(3, link_number + 1))
                z_new = protein(4, link_number + 1);
                z_new2= protein(4, link_number - 2);
                if (rand > 0.5)
                    y_new = protein(3, link_number + 1) + 1;
                    y_new2= protein(3, link_number - 2) + 1;
                else
                    y_new = protein(3, link_number + 1) - 1;
                    y_new2= protein(3, link_number - 2) - 1;
                end
            elseif (protein(4, link_number) == protein(4, link_number + 1))
                y_new = protein(3, link_number + 1);
                y_new2= protein(3, link_number - 2);
                if (rand > 0.5)
                    z_new = protein(4, link_number + 1) + 1;
                    z_new2= protein(4, link_number - 2) + 1;
                else
                    z_new = protein(4, link_number + 1) - 1;
                    z_new2= protein(4, link_number - 2) - 1;
                end
            end
        elseif (protein(3, link_number + 1) ~= protein(3, link_number - 2))
            y_new = protein(3, link_number + 1);
            y_new2= protein(3, link_number - 2);
            if (protein(2, link_number) == protein(2, link_number + 1))
                z_new = protein(4, link_number + 1);
                z_new2= protein(4, link_number - 2);
                if (rand > 0.5)
                    x_new = protein(2, link_number + 1) + 1;
                    x_new2= protein(2, link_number - 2) + 1;
                else
                    x_new = protein(2, link_number + 1) - 1;
                    x_new2= protein(2, link_number - 2) - 1;
                end
            elseif (protein(4, link_number) == protein(4, link_number + 1))
                x_new = protein(2, link_number + 1);
                x_new2= protein(2, link_number - 2);
                if (rand > 0.5)
                    z_new = protein(4, link_number + 1) + 1;
                    z_new2= protein(4, link_number - 2) + 1;
                else
                    z_new = protein(4, link_number + 1) - 1;
                    z_new2= protein(4, link_number - 2) - 1;
                end
            end
        elseif (protein(4, link_number + 1) ~= protein(4, link_number - 2))
            z_new = protein(4, link_number + 1);
            z_new2= protein(4, link_number - 2);
            if (protein(2, link_number) == protein(2, link_number + 1))
                y_new = protein(3, link_number + 1);
                y_new2= protein(3, link_number - 2);
                if (rand > 0.5)
                    x_new = protein(2, link_number + 1) + 1;
                    x_new2= protein(2, link_number - 2) + 1;
                else
                    x_new = protein(2, link_number + 1) - 1;
                    x_new2= protein(2, link_number - 2) - 1;
                end
            elseif (protein(3, link_number) == protein(3, link_number + 1))
                x_new = protein(2, link_number + 1);
                x_new2= protein(2, link_number - 2);
                if (rand > 0.5)
                    y_new = protein(3, link_number + 1) + 1;
                    y_new2= protein(3, link_number - 2) + 1;
                else
                    y_new = protein(3, link_number + 1) - 1;
                    y_new2= protein(3, link_number - 2) - 1;
                end
            end
        end
        % Check that selected movements are not being moved to occupied
        % positions, if selected positions are not already occupied, the
        % monomers are moved.
        if (~site_occupied(x_new, y_new, z_new, protein) && ~site_occupied(x_new2, y_new2, z_new2, protein))
            protein(2, link_number) = x_new;
            protein(3, link_number) = y_new;
            protein(4, link_number) = z_new;
            protein(2, link_number - 1) = x_new2;
            protein(3, link_number - 1) = y_new2;
            protein(4, link_number - 1) = z_new2;
        end
    % Crankshaft moves end
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