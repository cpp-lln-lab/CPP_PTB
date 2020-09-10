function FOV = computeFOV(cfg)
    % FOV = computeFOV(cfg)
    %
    % computes the number of degrees of visual angle in the whole field of view
    %
    % δ = 2 arctan ( d / 2D )
    %
    %  δ is the angular diameter, and d is the actual diameter of the object,
    %  and D is the distance to the object.
    %  The result obtained is in radians.
    %

    if cfg.screen.monitorDistance < 2
        errorDistanceToScreen(cfg);
    end

    FOV =  ...
        180 / pi * ...
        2 * atan(cfg.screen.monitorWidth / (2 * cfg.screen.monitorDistance));

end
