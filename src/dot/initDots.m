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
    
    % TODO
    % bound direction between 0 and 360 ??
    
    direction = thisEvent.direction(1);
    
    speedPixPerFrame = thisEvent.speed(1);

    lifeTime = cfg.dot.lifeTime;

    % decide which dots are signal dots (1) and those are noise dots (0)
    isSignal = rand(cfg.dot.number, 1) < cfg.dot.coherence;

    % for static dots
    if direction == -1
        speedPixPerFrame = 0;
        lifeTime = Inf;
        isSignal = true(cfg.dot.number, 1);
    end
    
    %% Set an array of dot positions [xposition, yposition]
    % These can never be bigger than 1 or lower than 0
    % [0,0] is the top / left of the square
    % [1,1] is the bottom / right of the square
    positions = rand(cfg.dot.number, 2) * cfg.screen.winWidth;

    %% Set vertical and horizontal speed for all dots 
    directionAllDots = setDotDirection(cfg, positions, direction, isSignal);
    
    [horVector, vertVector] = decomposeMotion(directionAllDots);
    speeds = [horVector, vertVector];
    
    % we were working with unit vectors. we now switch to pixels
    speeds = speeds * speedPixPerFrame;

    %% Create a vector to update to dotlife time of each dot
    % Not all set to 1 so the dots will die at different times
    % The maximum value is the duraion of the event in frames
    time = floor(rand(cfg.dot.number, 1) * cfg.eventDuration / cfg.screen.ifi);
    
    %% Convert from seconds to frames
    lifeTime = ceil(lifeTime / cfg.screen.ifi);
    
    %%
    dots.lifeTime = lifeTime;
    dots.time = time;
    dots.speeds = speeds;
    dots.isSignal = isSignal;
    dots.positions = positions;
end

function directionAllDots = setDotDirection(cfg, positions, direction, isSignal)
    
    directionAllDots = nan(cfg.dot.number, 1);
    
    direction = computeRadialMotionDirection(cfg, positions, direction);
    
    % Coherent dots
    directionAllDots(isSignal) = direction;
    % Random direction for the non coherent dots
    directionAllDots(~isSignal) = rand(sum(~isSignal), 1) * 360;
    directionAllDots = rem(directionAllDots,360);
    
end


