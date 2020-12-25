% (C) Copyright 2020 CPP_PTB developers

function dots = initDots(cfg, thisEvent)
    %
    % Initialize dots for RDK
    %
    % USAGE::
    %
    %   dots = initDots(cfg, thisEvent)
    %
    % :param cfg:
    % :type cfg: structure
    % :param thisEvent:
    % :type thisEvent: structure
    %
    % :returns: - :dots: (structure)
    %
    %
    % - ``cfg.dot.lifeTime``: dot life time in seconds
    % - ``cfg.dot.number``: number of dots
    % - ``cfg.dot.coherence``: proportion of coherent dots.
    %
    % - ``thisEvent.direction``: direction (an angle in degrees)
    % - ``thisEvent.speed``: speed expressed in pixels per frame
    %
    % - ``dots.direction``
    % - ``dots.isSignal``: signal dots (1) and those are noise dots (0)
    % - ``dots.directionAllDots``
    % - ``dots.lifeTime``: in frames
    % - ``dots.speeds``: ``[ndots, 2]`` ; horizontal and vertical speed ; in pixels per frame
    % - ``dots.speedPixPerFrame``
    %

    dots.direction = thisEvent.direction(1);

    dots.isSignal = rand(cfg.dot.number, 1) < cfg.dot.coherence;

    dots.speedPixPerFrame = thisEvent.speedPix(1);
    lifeTime = cfg.dot.lifeTime;

    % for static dots
    if dots.direction == -1
        dots.isSignal = true(cfg.dot.number, 1);
        dots.speedPixPerFrame = 0;
        lifeTime = Inf;
    end

    % set position and directions of the dots
    [dots.positions, dots.speeds, dots.time] = ...
        seedDots(dots, cfg, dots.isSignal);

    %% Convert from seconds to frames
    lifeTime = ceil(lifeTime / cfg.screen.ifi);
    dots.lifeTime = lifeTime;

end
