
function cfg = apertureTexture(action, cfg, thisEvent)
    
    matrixSize = 400;
    
    switch action
        
        case 'init'
            
            cfg.aperture.texture = Screen('MakeTexture', cfg.screen.win, ...
                cfg.color.background(1) * ones(cfg.screen.winRect([4 3])));
            
        case 'make'
            
            switch cfg.aperture.type
                
                case 'none'
                    
                    Screen('Fillrect', cfg.aperture.texture, [0 0 0 0]);
                      
                case 'circle'

                    Screen('FillOval', cfg.aperture.texture, [0 0 0 0], ...
                        CenterRectOnPoint([0 0 repmat(matrixSize, 1, 2)], ...
                        cfg.screen.winRect(3) / 2, cfg.screen.winRect(4) / 2));

            end
            
        case 'draw'
            
            Screen('DrawTexture', cfg.screen.win, cfg.aperture.texture);
            
            %         Screen('DrawTexture', cfg.screen.win, apertureTexture, ...
            %             cfg.screen.winRect, cfg.screen.winRect, current.apertureAngle - 90);
            
            
    end
    
    
    
    
    
    
end