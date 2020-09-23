function drawFieldOfVIew(cfg)
    % drawFieldOfVIew(cfg)
    %
    % draws a red rectangle on the screen to materialize the field of view of
    % the participant. This can be used during debugging to help design the
    % stimuli if you know the FOV of the participant will be obstructed by
    % something

    if isfield(cfg.screen, 'effectiveFieldOfView') && ...
        numel(cfg.screen.effectiveFieldOfView) == 2

        RED = [255 0 0];
        penWidth = 2;

        fov = cfg.screen.effectiveFieldOfView;

        fov = CenterRect( ...
                         [0, 0, fov(1), fov(2)], ...
                         cfg.screen.winRect);

        Screen('FrameRect', ...
               cfg.screen.win, ...
               RED, ...
               fov, ...
               penWidth);
    end

end
