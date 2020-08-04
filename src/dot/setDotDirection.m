function dots = setDotDirection(cfg, dots)

    directionAllDots = nan(cfg.dot.number, 1);

    % Coherent dots
    directionAllDots(dots.isSignal) = dots.direction;

    if strcmp(cfg.design.motionType, 'radial')
        angleMotion = computeRadialMotionDirection(cfg, dots);
        directionAllDots(dots.isSignal) = angleMotion;
    end

    % Random direction for the non coherent dots
    directionAllDots(~dots.isSignal) = rand(sum(~dots.isSignal), 1) * 360;
    directionAllDots = rem(directionAllDots, 360);

    dots.directionAllDots = directionAllDots;

end
