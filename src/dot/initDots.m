function [dots] = initDots(cfg, thisEvent)
    % [dots] = initDots(cfg, thisEvent)
    %
    % % Dot life time in seconds
    % cfg.dot.lifeTime
    % % Number of dots
    % cfg.dot.number
    % Proportion of coherent dots.
    % cfg.dot.coherence
    %
    % % Direction (an angle in degrees)
    % thisEvent.direction
    % % Speed expressed in pixels per frame
    % thisEvent.speed
    %
    %
    % dots.direction
    % dots.isSignal : signal dots (1) and those are noise dots (0)
    % dots.directionAllDots
    % dots.lifeTime : in frames
    % dots.speeds : [ndots, 2] ; horizontal and vertical speed ; in pixels per
    %   frame
    % dots.speedPixPerFrame

    dots.direction = thisEvent.direction(1);

    speedPixPerFrame = thisEvent.speed(1);

    lifeTime = cfg.dot.lifeTime;

    % decide which dots are signal dots (1) and those are noise dots (0)
    dots.isSignal = rand(cfg.dot.number, 1) < cfg.dot.coherence;

    % for static dots
    if dots.direction == -1
        speedPixPerFrame = 0;
        lifeTime = Inf;
        dots.isSignal = true(cfg.dot.number, 1);
    end

    %% Set an array of dot positions [xposition, yposition]
    % These can never be bigger than 1 or lower than 0
    % [0,0] is the top / left of the square
    % [1,1] is the bottom / right of the square
    dots.positions = generateNewDotPositions(cfg, cfg.dot.number);

    %% Set vertical and horizontal speed for all dots
    dots = setDotDirection(cfg, dots);

    [horVector, vertVector] = decomposeMotion(dots.directionAllDots);
    speeds = [horVector, vertVector];

    % we were working with unit vectors. we now switch to pixels
    speeds = speeds * speedPixPerFrame;

    %% Create a vector to update to dotlife time of each dot
    % Not all set to 1 so the dots will die at different times
    % The maximum value is the duraion of the event in frames
    time = floor(rand(cfg.dot.number, 1) * cfg.timing.eventDuration / cfg.screen.ifi);

    %% Convert from seconds to frames
    lifeTime = ceil(lifeTime / cfg.screen.ifi);

    %%
    dots.lifeTime = lifeTime;
    dots.time = time;
    dots.speeds = speeds;
    dots.speedPixPerFrame = speedPixPerFrame;

end
