function cartesianCoordinates = computeCartCoord(positions, dotMatrixWidth)
    %
    % USAGE::
    %
    %   cartesianCoordinates = computeCartCoord(positions, dotMatrixWidth)
    %
    % (C) Copyright 2020 CPP_PTB developers

    cartesianCoordinates = ...
        [positions(:, 1) - dotMatrixWidth / 2, ... % x coordinate
         positions(:, 2) - dotMatrixWidth / 2]; % y coordinate

end
