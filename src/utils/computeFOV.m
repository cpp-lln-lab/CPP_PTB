function FOV = computeFOV(cfg)
    %
    % Computes the number of degrees of visual angle in the whole field of view.
    %
    % USAGE::
    %
    %   FOV = computeFOV(cfg)
    %
    % :param cfg:
    % :type cfg: structure
    %
    % :returns: - :FOV: (scalar)
    %
    % ``delta = 2 arctan ( d / 2D )``
    %
    %   - delta is the angular diameter
    %   - d is the actual diameter of the object
    %   - D is the distance to the object
    %
    %  The result obtained is in radians.
    %

    % (C) Copyright 2020 CPP_PTB developers

    if cfg.screen.monitorDistance < 2
        errorDistanceToScreen(cfg);
    end

    FOV =  ...
        180 / pi * ...
        2 * atan(cfg.screen.monitorWidth / (2 * cfg.screen.monitorDistance));

end
