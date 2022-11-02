function relativeDensityContrast = dotMotionSimulation(cfg, thisEvent, nbEvents, doPlot)
    %
    % To simulate where the dots are more dense on the screen
    % relativeDensityContrast : hard to get it below 0.10.
    %
    % USAGE::
    %
    %   relativeDensityContrast = dotMotionSimulation(cfg, thisEvent, nbEvents, doPlot)
    %

    % (C) Copyright 2020 CPP_PTB developers

    close all;

    if nargin < 4
        doPlot = 1;
    end

    if nargin < 3
        nbEvents = 100;
    end

    if nargin < 2
        thisEvent.direction = 0; % degrees
        thisEvent.speed = 1; % pix per frame
    end

    if nargin < 1

        cfg.design.motionType = 'translation';

        cfg.dot.coherence = 1; % proportion

        cfg.dot.lifeTime = Inf; % in seconds

        cfg.dot.matrixWidth = 250; % in pixels

        cfg.dot.proportionKilledPerFrame = 0;

        cfg.timing.eventDuration = 1.8; % in seconds

    end

    % interframe interval
    cfg.screen.ifi = 0.016; % in seconds

    % size of the fixation is 1% of screen width
    cfg.fixation.widthPix = ceil(cfg.dot.matrixWidth * 1 / 100);

    % dot size
    cfg.dot.sizePix = 1;

    if ~isfield(cfg.dot, 'number')
        % We fill 25% of the screen with dots
        cfg.dot.number = round(cfg.dot.matrixWidth^2 * 25 / 100);
    end

    fprintf(1, '\n\nDot motion simulation:');

    nbFrames = ceil(cfg.timing.eventDuration / cfg.screen.ifi);

    % to keep track of where the dots have been
    dotDensity = zeros(cfg.dot.matrixWidth);

    for iEvent = 1:nbEvents

        [dots] = initDots(cfg, thisEvent);
        dotDensity = updateDotDensity(dotDensity, dots);

        for iFrame = 1:nbFrames

            [dots] = updateDots(dots, cfg);

            dotDensity = updateDotDensity(dotDensity, dots);

        end

    end

    %% Post sim
    % trim the edges (to avoid super high/low values
    dotDensity = dotDensity(2:end - 1, 2:end - 1);

    % computes the maximum difference in dot density over the all screen
    % to be used for unit test
    relativeDensityContrast = (max(dotDensity(:)) - min(dotDensity(:))) / max(dotDensity(:));

    if doPlot
        imagesc(dotDensity);
        axis square;
        title('dot density');
    end

    fprintf(1, '\n');

end

function dotDensity = updateDotDensity(dotDensity, dots)

    x = round(dots.positions(:, 1));
    x = avoidEdgeValues(x, size(dotDensity, 2));

    y = round(dots.positions(:, 2));
    y = avoidEdgeValues(y, size(dotDensity, 1));

    ind = sub2ind(size(dotDensity), y, x);

    dotDensity(ind) = dotDensity(ind) + 1;

end

function x = avoidEdgeValues(x, dim)
    x(x < 1) = 1;
    x(x > dim) = dim;
end
