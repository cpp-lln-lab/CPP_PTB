function directionAllDots = setDotDirection(positions, cfg, dots, isSignal)
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

    directionAllDots = dots.direction;

    % when we initialiaze the direction for all the dots
    % after that dots.direction will be a vector
    if numel(directionAllDots) == 1

        directionAllDots(isSignal) = ones(sum(isSignal), 1) * dots.direction;

    end

    %% Coherent dots
    if strcmp(cfg.design.motionType, 'radial')

        angleMotion = computeRadialMotionDirection(positions, cfg.dot.matrixWidth, dots);

        directionAllDots(isSignal) = angleMotion;

    end

    %% Random direction for the non coherent dots
    directionAllDots(~isSignal) = rand(sum(~isSignal), 1) * 360;

    %% Express the direction in the 0 to 360 range
    directionAllDots = mod(directionAllDots, 360);

    % ensure we return a colum vector
    if size(directionAllDots, 1) == 1
        directionAllDots = directionAllDots';
    end

end
