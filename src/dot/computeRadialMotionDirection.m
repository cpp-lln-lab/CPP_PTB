function angleMotion = computeRadialMotionDirection(positions, dotMatrixWidth, dots)

    cartesianCoordinates = computeCartCoord(positions, dotMatrixWidth);

    [angleMotion, ~] = cart2pol(cartesianCoordinates(:, 1), cartesianCoordinates(:, 2));
    angleMotion = angleMotion / pi * 180;

    if dots.direction == -666
        angleMotion = angleMotion - 180;
    end

end
