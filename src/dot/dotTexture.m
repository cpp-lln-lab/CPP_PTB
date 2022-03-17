function cfg = dotTexture(action, cfg, thisEvent)
    %
    % (C) Copyright 2020 CPP_PTB developers
    switch action

        case 'init'
            cfg.dot.texture = Screen('MakeTexture', cfg.screen.win, ...
                                     cfg.color.background(1) * ...
                                     ones(cfg.screen.winRect([4 3])));

        case 'make'

            dotType = 2;

            xCenter = cfg.screen.center(1) + thisEvent.dotCenterXPosPix;
            yCenter = cfg.screen.center(2);

            if isfield(thisEvent, 'dotCenterYPosPix')
                yCenter = cfg.screen.center(2) + thisEvent.dotCenterYPosPix;
            end

            Screen('FillRect', cfg.dot.texture, cfg.color.background);
            Screen('DrawDots', cfg.dot.texture, ...
                   thisEvent.dot.positions, ...
                   cfg.dot.sizePix, ...
                   cfg.dot.color, ...
                   [xCenter yCenter], ...
                   dotType);

        case 'draw'

            Screen('DrawTexture', cfg.screen.win, cfg.dot.texture);

    end

end
