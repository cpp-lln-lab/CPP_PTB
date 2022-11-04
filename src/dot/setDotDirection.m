function directionAllDots = setDotDirection(positions, cfg, dots, isSignal)
    %
    % Creates some new direction for the dots.
    %
    % USAGE::
    %
    %   directionAllDots = setDotDirection(positions, cfg, dots, isSignal)
    %
    % :param positions:
    % :type positions:
    % :param cfg:
    % :type cfg:
    % :param dots:
    % :type dots:
    % :param isSignal:
    % :type isSignal:
    %
    % :returns: - :directionAllDots:
    %
    % Coherent dots have a true value in the vector ``isSignal``
    % and get assigned a value equals to the one in ``dots.direction``.
    %
    % All the other dots get a random value between 0 and 360.
    %
    % All directions are in end expressed between 0 and 360.
    %

    % (C) Copyright 2020 CPP_PTB developers

    directionAllDots = dots.direction;

    % when we initialize the direction for all the dots
    % after that dots.direction will be a vector
    if numel(directionAllDots) == 1

        directionAllDots = ones(sum(isSignal), 1) * dots.direction;

    end

    %% Coherent dots
    if strcmp(cfg.design.motionType, 'radial')

        angleMotion = computeRadialMotionDirection(positions, cfg.dot.matrixWidth, dots);

        directionAllDots(isSignal == 1) = angleMotion;

    end

    %% Random direction for the non coherent dots
    directionAllDots(isSignal ~= 1) = rand(sum(isSignal ~= 1), 1) * 360;

    %% Express the direction in the 0 to 360 range
    directionAllDots = mod(directionAllDots, 360);

    % ensure we return a column vector
    if size(directionAllDots, 1) == 1
        directionAllDots = directionAllDots';
    end

end
