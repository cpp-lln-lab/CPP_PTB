function standByScreen(cfg)

    Screen('FillRect', cfg.screen.win, cfg.color.background, cfg.screen.winRect);

    DrawFormattedText(cfg.screen.win, ...
        cfg.task.instruction, ...
        'center', 'center', cfg.text.color);

    Screen('Flip', cfg.screen.win);

    % Wait for space key to be pressed
    pressSpaceForMe();

end
