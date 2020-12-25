% (C) Copyright 2020 CPP_PTB developers

function waitFor(cfg, timeToWait)
    %
    % Will either wait for a certain amount of time or a number of triggers.
    %
    % USAGE::
    %
    %   waitFor(cfg, timeToWait)
    %
    if cfg.pacedByTriggers.do
        waitForTrigger( ...
                       cfg, ...
                       cfg.keyboard.responseBox, ...
                       cfg.pacedByTriggers.quietMode, ...
                       timeToWait);
    else
        WaitSecs(timeToWait);
    end

end
