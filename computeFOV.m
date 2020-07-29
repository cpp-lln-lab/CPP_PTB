function FOV = computeFOV(cfg)
    % FOV = computeFOV(cfg)
    % computes the number of degrees of visual angle in the whole field of view
    %

    FOV = 2 * (180 * (atan(cfg.monitorWidth / (2 * cfg.screenDistance)) / pi));

end
