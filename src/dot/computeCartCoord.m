function cartesianCoordinates = computeCartCoord(positions, dotMatrixWidth)
    
    cartesianCoordinates = ...
        [positions(:, 1) - dotMatrixWidth / 2, ... % x coordinate
         positions(:, 2) - dotMatrixWidth / 2]; % y coordinate

    %         cartesianCoordinates = positions;
end
