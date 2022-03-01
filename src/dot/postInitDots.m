function cfg = postInitDots(cfg)
    %
    % cfg = postInitDots(cfg)
    %
    % generic function to finalize dots set up after psychtoolbox initialization
    %
    %
    % (C) Copyright 2022 CPP_PTB developers

    cfg.dot.matrixWidth = cfg.screen.winWidth;

    % Convert some values from degrees to pixels
    cfg.dot = degToPix('size', cfg.dot, cfg);
    cfg.dot = degToPix('speed', cfg.dot, cfg);

    % Get dot speeds in pixels per frame
    cfg.dot.speedPixPerFrame = cfg.dot.speedPix / cfg.screen.monitorRefresh;

    cfg.aperture = degToPix('xPos', cfg.aperture, cfg);

    % dots are displayed on a square with a length in visual angle equal to the
    % field of view
    cfg.dot.number = round(cfg.dot.density * ...
                           (cfg.dot.matrixWidth / cfg.screen.ppd)^2);

end
