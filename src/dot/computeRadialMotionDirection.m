% (C) Copyright 2020 CPP_PTB developers

function angleMotion = computeRadialMotionDirection(positions, dotMatrixWidth, dots)

    positions = computeCartCoord(positions, dotMatrixWidth);

    [angleMotion, ~] = cart2pol(positions(:, 1), positions(:, 2));
    angleMotion = angleMotion / pi * 180;

    if dots.direction == -666
        angleMotion = angleMotion - 180;
    end

end
