function farewellScreen(cfg, message)
    %
    % (C) Copyright 2020 CPP_PTB developers

    if nargin < 2
        message = 'Thank you for participating in this experiment.';
    end

    Screen('FillRect', cfg.screen.win, cfg.color.background, cfg.screen.winRect);
    DrawFormattedText(cfg.screen.win, message, 'center', 'center', cfg.text.color);
    Screen('Flip', cfg.screen.win);
    if isfield(cfg, 'mri')
        WaitSecs(cfg.mri.repetitionTime * 2);
    end

end
