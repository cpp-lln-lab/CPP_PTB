function [dots] = initDots(cfg, thisEvent)

    direction = thisEvent.direction(1);

    dots.lifeTime = cfg.dot.lifeTime;

    speedPixPerFrame = thisEvent.speed(1);

    % decide which dots are signal dots (1) and those are noise dots (0)
    dots.isSignal = rand(cfg.dot.number, 1) < cfg.dot.coherence;

    % for static dots
    if direction == -1
        speedPixPerFrame = 0;
        dots.lifeTime = Inf;
        dots.isSignal = true(cfg.dot.number, 1);
    end

    % Convert from seconds to frames
    dots.lifeTime = ceil(dots.lifeTime / cfg.screen.ifi);

    % Set an array of dot positions [xposition, yposition]
    % These can never be bigger than 1 or lower than 0
    % [0,0] is the top / left of the square
    % [1,1] is the bottom / right of the square
    dots.positions = rand(cfg.dot.number, 2) * cfg.screen.winWidth;

    % Set a N x 2 matrix that speed in X and Y
    dots.speeds = nan(cfg.dot.number, 2);

    % Coherent dots
    [horVector, vertVector] = decompMotion(direction);
    dots.speeds(dots.isSignal, :) = ...
        repmat([horVector, vertVector], sum(dots.isSignal), 1);

    % Random direction for the non coherent dots
    if any(~dots.isSignal)
        randomDirection = rand(sum(~dots.isSignal), 1) * 360;
        [horVector, vertVector] = decompMotion(randomDirection);
        dots.speeds(~dots.isSignal, :) = [horVector, vertVector];
    end

    % So far we were working wiht unit vectors convert that speed in pixels per
    % frame
    dots.speeds = dots.speeds * speedPixPerFrame;

    % Create a vector to update to dotlife time of each dot
    % Not all set to 1 so the dots will die at different times
    % The maximum value is the duraion of the event in frames
    dots.time = floor(rand(cfg.dot.number, 1) * cfg.eventDuration / cfg.screen.ifi);

end
