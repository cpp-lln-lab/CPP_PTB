% (C) Copyright 2020 CPP_PTB developers

function cartesianCoordinates = computeCartCoord(positions, dotMatrixWidth)

    cartesianCoordinates = ...
        [positions(:, 1) - dotMatrixWidth / 2, ... % x coordinate
         positions(:, 2) - dotMatrixWidth / 2]; % y coordinate

end
