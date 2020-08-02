function cfg = apertureTexture(action, cfg, thisEvent)
    
    transparent = [0 0 0 0];
    
    switch action
        
        case 'init'
            
            % we take the screen height as maximum aperture width if not
            % specified.
            if ~isfield(cfg.aperture, 'width') || isempty(cfg.aperture.width)
                cfg.aperture.width = cfg.screen.winRect(4) / cfg.screen.ppd;
            end
            cfg.aperture = degToPix('width', cfg.aperture, cfg);

            cfg.aperture.texture = Screen('MakeTexture', cfg.screen.win, ...
                cfg.color.background(1) * ones(cfg.screen.winRect([4 3])));
            
        case 'make'
            
            switch cfg.aperture.type
                
                case 'none'
                    
                    Screen('Fillrect', cfg.aperture.texture, transparent);
                      
                case 'circle'

                    diameter = cfg.aperture.widthPix;

                    Screen('FillOval', cfg.aperture.texture, transparent, ...
                        CenterRectOnPoint([0 0 repmat(diameter, 1, 2)], ...
                        cfg.screen.winRect(3) / 2, cfg.screen.winRect(4) / 2));

            end
            
        case 'draw'
            
            Screen('DrawTexture', cfg.screen.win, cfg.aperture.texture);
            
            % Screen('DrawTexture', cfg.screen.win, apertureTexture, ...
            % cfg.screen.winRect, cfg.screen.winRect, current.apertureAngle - 90);
                        
    end

end