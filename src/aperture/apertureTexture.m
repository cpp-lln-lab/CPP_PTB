function [cfg, thisEvent] = apertureTexture(action, cfg, thisEvent)
    
    transparent = [0 0 0 0];
    
    switch action
        
        case 'init'
            
            switch cfg.aperture.type
                
                case 'circle'
                    % we take the screen height as maximum aperture width if not
                    % specified.
                    if ~isfield(cfg.aperture, 'width') || isempty(cfg.aperture.width)
                        cfg.aperture.width = cfg.screen.winRect(4) / cfg.screen.ppd;
                    end
                    cfg.aperture = degToPix('width', cfg.aperture, cfg);
                    
                case 'ring'
                    
                    % Set parameters for rings
                    if strcmp(cfg.aperture.type ,'ring')
                        % scale of outer ring (exceeding screen until
                        % inner ring reaches window boarder)
                        cfg.ring.maxEcc = ...
                            cfg.screen.FOV / 2 + ...
                            cfg.aperture.width + ...
                            log(cfg.screen.FOV / 2 + 1) ;
                        % ring.CsFuncFact is used to expand with log increasing speed so
                        % that ring is at ring.maxEcc at end of cycle
                        cfg.ring.csFuncFact = ...
                            1 / ...
                            ((cfg.ring.maxEcc + exp(1)) * ...
                            log(cfg.ring.maxEcc + exp(1)) - ...
                            (cfg.ring.maxEcc + exp(1))) ;
                    end
            end
            
            cfg.aperture.texture = Screen('MakeTexture', cfg.screen.win, ...
                cfg.color.background(1) * ones(cfg.screen.winRect([4 3])));
            
        case 'make'
            
            xCenter = cfg.screen.center(1);
            yCenter = cfg.screen.center(2);
            
            switch cfg.aperture.type
                
                case 'none'
                    
                    Screen('Fillrect', cfg.aperture.texture, transparent);
                    
                case 'circle'
                    
                    diameter = cfg.aperture.widthPix;
                    
                    if isfield(cfg.aperture, 'xPosPix')
                        xCenter = cfg.screen.center(1) + cfg.aperture.xPosPix;
                    end
                    if isfield(cfg.aperture, 'yPosPix')
                        yCenter = cfg.screen.center(2) + cfg.aperture.yPosPix;
                    end
                    
                    Screen('FillOval', cfg.aperture.texture, transparent, ...
                        CenterRectOnPoint([0 0 repmat(diameter, 1, 2)], ...
                        xCenter, yCenter));
                    
                case 'ring'
                    
                    % expansion speed is log over eccentricity
                    [cfg] = eccenLogSpeed(cfg, thisEvent.time);
                    
                    Screen('Fillrect', cfg.aperture.texture, cfg.color.background);
                    
                    Screen('FillOval', cfg.aperture.texture, transparent, ...
                        CenterRectOnPoint( ...
                        [0 0 repmat(cfg.ring.outerRimPix, 1, 2)], ...
                        xCenter, yCenter));
                    
                    Screen('FillOval', cfg.aperture.texture, [cfg.color.background 255], ...
                        CenterRectOnPoint( ...
                        [0 0 repmat(cfg.ring.innerRimPix, 1, 2)], ...
                        xCenter, yCenter));
                    
                case 'wedge'
                    
                    cycleDuration = cfg.mri.repetitionTime * cfg.volsPerCycle;
                    
                    % Update angle for rotation of background and for apperture for wedge
                    switch cfg.direction
                        
                        case '+'
                            thisEvent.angle = 90 - ...
                                cfg.aperture.width / 2 + ...
                                (thisEvent.time / cycleDuration) * 360;
                        case '-'
                            thisEvent.angle = 90 - ...
                                cfg.aperture.width / 2 - ...
                                (thisEvent.time / cycleDuration) * 360;
                            
                    end
                    
                    Screen('Fillrect', cfg.aperture.texture, cfg.color.background);
                    
                    Screen('FillArc', cfg.aperture.texture, transparent, ...
                        CenterRect( ...
                        [0 0 repmat(cfg.stimRect(4), 1, 2)], ...
                        cfg.screen.winRect), ...
                        thisEvent.angle, ... % start angle
                        cfg.aperture.width); % arc angle
                    
                    
                otherwise
                    
                    error('unknown aperture type: %s.', cfg.aperture.type);
                    
            end
            
        case 'draw'
            
            Screen('DrawTexture', cfg.screen.win, cfg.aperture.texture);
            
            % Screen('DrawTexture', cfg.screen.win, apertureTexture, ...
            % cfg.screen.winRect, cfg.screen.winRect, current.apertureAngle - 90);
            
    end
    
end
