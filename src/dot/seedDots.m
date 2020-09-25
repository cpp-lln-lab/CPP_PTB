function [positions, speeds, time] = seedDots(varargin)

    [dots, cfg, isSignal] = deal(varargin{:});

    nbDots = numel(isSignal);

    %% Set an array of dot positions [xposition, yposition]
    % These can never be bigger than 1 or lower than 0
    % [0,0] is the top / left of the square
    % [1,1] is the bottom / right of the square
    positions = generateNewDotPositions(cfg.dot.matrixWidth, nbDots);

    %% Set vertical and horizontal speed for all dots
    directionAllDots = setDotDirection(positions, cfg, dots, isSignal);
    [horVector, vertVector] = decomposeMotion(directionAllDots);

    % we were working with unit vectors. we now switch to pixels
    speeds = [horVector, vertVector] * dots.speedPixPerFrame;

    %% Create a vector to update to dotlife time of each dot
    % Not all set to 1 so the dots will die at different times
    % The maximum value is the duraion of the event in frames
    time = floor(rand(nbDots, 1) * cfg.timing.eventDuration / cfg.screen.ifi);

end
