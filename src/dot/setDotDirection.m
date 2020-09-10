function dots = setDotDirection(cfg, dots)
    % dots = setDotDirection(cfg, dots)
    %
    % creates some new direction for the dots
    %
    % coherent dots have a true value in the vector dots.isSignal and get
    % assigned a value equals to the one in dots.direction
    %
    % all the other dots get a random value between 0 and 360.
    %
    % all directions are in end expressed between 0 and 360

    directionAllDots = nan(cfg.dot.number, 1);

    % Coherent dots

    if numel(dots.direction) == 1
        dots.direction = ones(sum(dots.isSignal), 1) * dots.direction;
    elseif numel(dots.direction) ~= sum(dots.isSignal)
        error(['dots.direction must have one element' ...
               'or as many element as there are coherent dots']);
    end

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
