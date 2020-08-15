function cfg = getExperimentEnd(cfg)

    drawFixation(cfg);
    endExpmt = Screen('Flip', cfg.screen.win);

    disp(' ');
    ExpmtDur = endExpmt - cfg.experimentStart;
    ExpmtDurMin = floor(ExpmtDur / 60);
    ExpmtDurSec = mod(ExpmtDur, 60);
    disp(['Experiment lasted ', ...
        num2str(ExpmtDurMin), ' minutes ', ...
        num2str(ExpmtDurSec), ' seconds']);
    disp(' ');

end
