function standByScreen(cfg)
    %
    % It shows a basic one-page instruction stored in `cfg.task.instruction` and wait
    % for `space` stroke.
    %
    % USAGE::
    %
    %  standByScreen(cfg)
    %
    % (C) Copyright 2020 CPP_PTB developers

    Screen('FillRect', cfg.screen.win, cfg.color.background, cfg.screen.winRect);

    DrawFormattedText(cfg.screen.win, ...
                      cfg.task.instruction, ...
                      'center', 'center', cfg.text.color);

    Screen('Flip', cfg.screen.win);

    % Wait for space key to be pressed
    pressSpaceForMe();

end
