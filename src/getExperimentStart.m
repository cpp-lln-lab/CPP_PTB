% (C) Copyright 2020 CPP_PTB developers

function cfg = getExperimentStart(cfg)
    %
    % Wrapper function that will show a fixation cross and collect a start timestamp
    % in ``cfg.experimentStart``
    %
    % USAGE::
    %
    %   cfg = getExperimentStart(cfg)
    %

    drawFixation(cfg);
    vbl = Screen('Flip', cfg.screen.win);
    cfg.experimentStart = vbl;

end
