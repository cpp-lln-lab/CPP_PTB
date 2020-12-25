% (C) Copyright 2020 CPP_PTB developers

function fov = drawFieldOfVIew(cfg, centerOnScreen)
    %
    % Draws a red rectangle on the screen to materialize the field of view of
    % the participant. This can be used during debugging to help design the
    % stimuli if you know the FOV of the participant will be obstructed by
    % something
    %
    % USAGE::
    %
    %   fov = drawFieldOfVIew(cfg, centerOnScreen)
    %
    % :param cfg:
    % :type cfg: structure
    % :param centerOnScreen:
    % :type centerOnScreen: boolean
    %
    % :returns: - :fov: (array) PTB rectangle
    %

    if nargin < 2
        centerOnScreen = true;
    end

    fov = [];

    if isfield(cfg.screen, 'effectiveFieldOfView') && ...
        numel(cfg.screen.effectiveFieldOfView) == 4

        RED = [255 0 0];
        penWidth = 2;

        fov = cfg.screen.effectiveFieldOfView;

        if centerOnScreen
            fov = CenterRect( ...
                             fov, ...
                             cfg.screen.winRect);
        end

        Screen('FrameRect', ...
               cfg.screen.win, ...
               RED, ...
               fov, ...
               penWidth);
    end

end
