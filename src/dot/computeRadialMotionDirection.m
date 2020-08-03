function direction = computeRadialMotionDirection(cfg, positions, direction)
    if strcmp(cfg.design.motionType, 'radial')

        cartesianCoordinates = positions - cfg.screen.winWidth /  2;

        [angle, ~] = cart2pol(cartesianCoordinates(:, 1), cartesianCoordinates(:, 2));
        angle = angle / pi * 180;

        if direction == -666
            angle = angle - 180;
        end

        direction = angle;

    end
end
