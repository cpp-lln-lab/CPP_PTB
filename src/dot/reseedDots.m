function dots = reseedDots(dots, cfg)
    
    fixationWidthPix = 0;
    if isfield(cfg.fixation, 'widthPix')
        fixationWidthPix = cfg.fixation.widthPix;
    end
    
    cartesianCoordinates = computeCartCoord(dots.positions, cfg);
    [~, radius] = cart2pol(cartesianCoordinates(:, 1), cartesianCoordinates(:, 2));
    

    
    % Create a logical vector to detect any dot that has:
    % - an xy position inferior to 0
    % - an xy position superior to winWidth
    % - has exceeded its liftime
    % - is on the fixation cross
    % - has been been picked to be killed
    
    N = any([ ...
        dots.positions > cfg.dot.matrixWidth, ...
        dots.positions < 0, ...
        dots.time > dots.lifeTime, ...
        radius - cfg.dot.sizePix < fixationWidthPix / 2, ...
        rand(cfg.dot.number, 1) < cfg.dot.proportionKilledPerFrame, ...
        ], 2) ;
    
    % If there is any such dot we relocate it to a new random position
    % and change its lifetime to 1
    if any(N)
        
        dots.positions(N, :) = generateNewDotPositions(cfg, sum(N));
        
        dots = setDotDirection(cfg, dots);
        
        [horVector, vertVector] = decomposeMotion(dots.directionAllDots);
        dots.speeds = [horVector, vertVector] * dots.speedPixPerFrame;
        
        dots.time(N, 1) = 1;
        
    end
    
end