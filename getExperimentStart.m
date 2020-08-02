function cfg = getExperimentStart(cfg)
    % Show the fixation cross
    drawFixation(cfg);
    vbl = Screen('Flip', cfg.screen.win);
    cfg.experimentStart = vbl;
end