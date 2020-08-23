function waitFor(cfg, timeToWait)
    % waitFor(cfg, timeToWait)
    %
    % Will either wait for a certain amount of time or a number of triggers

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
