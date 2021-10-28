function cfg = getExperimentStart(cfg)
    %
    % Wrapper function that will show a fixation cross and collect a start timestamp
    % in ``cfg.experimentStart``
    %
    % USAGE::
    %
    %   cfg = getExperimentStart(cfg)
    %
    % (C) Copyright 2020 CPP_PTB developers

    drawFixation(cfg);
    vbl = Screen('Flip', cfg.screen.win);
    cfg.experimentStart = vbl;

end
