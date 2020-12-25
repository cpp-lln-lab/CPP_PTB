% (C) Copyright 2020 CPP_PTB developers

function cfg = getExperimentEnd(cfg)
    %
    % Wrapper function that will show a fixation cross and display in the console the
    % whole experiment's duration in minutes and seconds
    %

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
