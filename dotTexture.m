function cfg = dotTexture(action, cfg, thisEvent)
    
    switch action
        
        case 'init'
            cfg.dot.texture = Screen('MakeTexture', cfg.screen.win, ...
                cfg.color.background(1) * ones(cfg.screen.winRect([4 3])));
            
        case 'make'
            
            Screen('FillRect', cfg.dot.texture, cfg.color.background);
            Screen('DrawDots', cfg.dot.texture, ...
                thisEvent.dot.position, ...
                cfg.dot.sizePix, ...
                cfg.dot.color, ...
                cfg.screen.center, ...
                1);
            
        case 'draw'
            
            Screen('DrawTexture', cfg.screen.win, cfg.dot.texture);
            
            
    end
    
end