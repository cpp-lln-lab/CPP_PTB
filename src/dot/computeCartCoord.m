function cartesianCoordinates = computeCartCoord(positions, cfg)
    cartesianCoordinates = ...
        [positions(:, 1) - cfg.dot.matrixWidth / 2, ... % x coordinate
         positions(:, 2) - cfg.dot.matrixWidth / 2]; % y coordinate

    %         cartesianCoordinates = positions;
end
