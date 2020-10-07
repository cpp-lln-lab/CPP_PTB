% (C) Copyright 2020 CPP_PTB developers

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

    % decide which dots are signal dots (1) and those are noise dots (0)
    dots.isSignal = rand(cfg.dot.number, 1) < cfg.dot.coherence;

    dots.speedPixPerFrame = thisEvent.speedPix(1);
    lifeTime = cfg.dot.lifeTime;

    % for static dots
    if dots.direction == -1
        dots.isSignal = true(cfg.dot.number, 1);
        dots.speedPixPerFrame = 0;
        lifeTime = Inf;
    end

    % set position and directions fo the dots
    [dots.positions, dots.speeds, dots.time] = ...
        seedDots(dots, cfg, dots.isSignal);

    %% Convert from seconds to frames
    lifeTime = ceil(lifeTime / cfg.screen.ifi);
    dots.lifeTime = lifeTime;

end
