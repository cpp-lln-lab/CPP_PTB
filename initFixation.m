function cfg = initFixation(cfg)
    
    % Convert some values from degrees to pixels
    cfg.fixation = degToPix('width', cfg.fixation, cfg);
    cfg.fixation = degToPix('xDisplacement', cfg.fixation, cfg);
    cfg.fixation = degToPix('yDisplacement', cfg.fixation, cfg);

    if strcmp(cfg.fixation.type, 'cross')

        % Prepare fixation cross
        cfg.fixation.xCoords = [-cfg.fixation.widthPix cfg.fixation.widthPix 0 0] / 2 + ...
            cfg.fixation.xDisplacementPix;
        cfg.fixation.yCoords = [0 0 -cfg.fixation.widthPix cfg.fixation.widthPix] / 2 + ...
            cfg.fixation.yDisplacementPix;
        cfg.fixation.allCoords = [cfg.fixation.xCoords; cfg.fixation.yCoords];

    end

end
