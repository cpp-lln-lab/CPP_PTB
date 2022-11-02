function farewellScreen(cfg)
    %

    % (C) Copyright 2020 CPP_PTB developers

    Screen('FillRect', cfg.screen.win, cfg.color.background, cfg.screen.winRect);
    DrawFormattedText(cfg.screen.win, 'Thank you!', 'center', 'center', cfg.text.color);
    Screen('Flip', cfg.screen.win);
    if isfield(cfg, 'mri')
        WaitSecs(cfg.mri.repetitionTime * 2);
    end

end
