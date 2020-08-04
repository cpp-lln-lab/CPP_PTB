function cfg = initFixation(cfg)

    % Convert some values from degrees to pixels
    cfg.fixation = degToPix('width', cfg.fixation, cfg);
    cfg.fixation = degToPix('xDisplacement', cfg.fixation, cfg);
    cfg.fixation = degToPix('yDisplacement', cfg.fixation, cfg);

    % Prepare fixation cross
    xLine = [-cfg.fixation.widthPix cfg.fixation.widthPix 0 0] / 2;
    yLine = [0 0 -cfg.fixation.widthPix cfg.fixation.widthPix] / 2;

    cfg.fixation.xCoords =  xLine + cfg.fixation.xDisplacementPix;
    cfg.fixation.yCoords =  yLine + cfg.fixation.yDisplacementPix;

    cfg.fixation.allCoords = [cfg.fixation.xCoords; cfg.fixation.yCoords];

    switch cfg.fixation.type

        case 'bestFixation'

            % Code adapted from:
            % What is the best fixation target?
            % DOI 10.1016/j.visres.2012.10.012

            cfg.fixation.outerOval = [ ...
                cfg.screen.center(1) - cfg.fixation.widthPix / 2, ...
                cfg.screen.center(2) - cfg.fixation.widthPix / 2, ...
                cfg.screen.center(1) + cfg.fixation.widthPix / 2, ...
                cfg.screen.center(2) + cfg.fixation.widthPix / 2];

            cfg.fixation.innerOval = [ ...
                cfg.screen.center(1) - cfg.fixation.widthPix / 6, ...
                cfg.screen.center(2) - cfg.fixation.widthPix / 6, ...
                cfg.screen.center(1) + cfg.fixation.widthPix / 6, ...
                cfg.screen.center(2) + cfg.fixation.widthPix / 6];

    end

end
