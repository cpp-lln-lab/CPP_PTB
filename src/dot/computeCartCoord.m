function cartesianCoordinates = computeCartCoord(positions, cfg)
    cartesianCoordinates = ...
        [positions(:,1) - cfg.screen.winWidth /  2, ... % x coordinate
        positions(:,2) + cfg.screen.winWidth / 2]; % y coordinate
end