% (C) Copyright 2010-2020 Sam Schwarzkopf
% (C) Copyright 2020 CPP_PTB developers

function [cfg, thisEvent] = apertureTexture(action, cfg, thisEvent)
    %
    % USAGE::
    %
    %   [cfg, thisEvent] = apertureTexture(action, cfg, thisEvent)
    %
    %

    switch action

        case 'init'

            cfg = apertureInit(cfg);

            cfg.aperture.texture = Screen('MakeTexture', cfg.screen.win, ...
                                          cfg.color.background(1) * ...
                                          ones(cfg.screen.winRect([3 3])));

        case 'make'

            cfg = apertureTextureMake(cfg, thisEvent);

        case 'draw'

            scalingFactor = 1;
            if isfield(cfg, 'scalingFactor') && ~isempty(cfg.scalingFactor)
                scalingFactor = cfg.scalingFactor;
            end

            rotationAngle = [];
            if strcmp(cfg.aperture.type, 'bar')
                rotationAngle = thisEvent.condition - 90;
            end

            Screen('DrawTexture', cfg.screen.win, cfg.aperture.texture, ...
                   cfg.screen.winRect, ...
                   CenterRect(cfg.screen.winRect * scalingFactor, cfg.screen.winRect), ...
                   rotationAngle);

    end

end

function cfg = apertureInit(cfg)

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
            if strcmp(cfg.aperture.type, 'ring')
                % scale of outer ring (exceeding screen until
                % inner ring reaches window boarder)
                cfg.ring.maxEcc = ...
                    cfg.screen.FOV / 2 + ...
                    cfg.aperture.width + ...
                    log(cfg.screen.FOV / 2 + 1);
                % ring.CsFuncFact is used to expand with log increasing speed so
                % that ring is at ring.maxEcc at end of cycle
                cfg.ring.csFuncFact = ...
                    1 / ...
                    ((cfg.ring.maxEcc + exp(1)) * ...
                     log(cfg.ring.maxEcc + exp(1)) - ...
                     (cfg.ring.maxEcc + exp(1)));
            end

        case 'bar'

            % Set parameters drifting bars
            cfg.aperture.barWidthPix = cfg.stimRect(3) / cfg.volsPerCycle;

            barPosPix = ...
                [0:cfg.aperture.barWidthPix:cfg.stimRect(3) - cfg.aperture.barWidthPix] + ...
                (cfg.screen.winRect(3) / 2 - cfg.stimRect(3) / 2) + ...
                cfg.aperture.barWidthPix / 2; %#ok<NBRAK>

            cfg.aperture.barPosPix = barPosPix;

            % Width of bar in degrees of VA (needed for saving)
            cfg.aperture.width = cfg.aperture.barWidthPix / cfg.screen.ppd;
            cfg.aperture.barPos = ...
                (cfg.aperture.barPosPix - cfg.screen.center(1)) / ...
                cfg.screen.ppd;

    end

end

function cfg = apertureTextureMake(cfg, thisEvent)

    TRANSPARENT = [0, 0, 0, 0];

    xCenter = cfg.screen.center(1);
    yCenter = cfg.screen.center(2);

    switch cfg.aperture.type

        case 'none'

            Screen('Fillrect', cfg.aperture.texture, TRANSPARENT);

        case 'circle'

            Screen('Fillrect', cfg.aperture.texture, cfg.color.background);

            diameter = cfg.aperture.widthPix;

            if isfield(cfg.aperture, 'xPosPix')
                xCenter = xCenter + cfg.aperture.xPosPix;
            end
            if isfield(cfg.aperture, 'yPosPix')
                yCenter = yCenter + cfg.aperture.yPosPix;
            end

            Screen('FillOval', cfg.aperture.texture, TRANSPARENT, ...
                   CenterRectOnPoint([0, 0, repmat(diameter, 1, 2)], ...
                                     xCenter, yCenter));

        case 'ring'

            % expansion speed is log over eccentricity
            [cfg] = eccenLogSpeed(cfg, thisEvent.time);

            Screen('Fillrect', cfg.aperture.texture, cfg.color.background);

            Screen('FillOval', cfg.aperture.texture, TRANSPARENT, ...
                   CenterRectOnPoint( ...
                                     [0, 0, repmat(cfg.ring.outerRimPix, 1, 2)], ...
                                     xCenter, yCenter));

            Screen('FillOval', cfg.aperture.texture, [cfg.color.background 255], ...
                   CenterRectOnPoint( ...
                                     [0, 0, repmat(cfg.ring.innerRimPix, 1, 2)], ...
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

            Screen('FillArc', cfg.aperture.texture, TRANSPARENT, ...
                   CenterRect( ...
                              cfg.destinationRect, ...
                              cfg.screen.winRect), ...
                   thisEvent.angle, ... % start angle
                   cfg.aperture.width); % arc angle

        case 'bar'

            % aperture is the color of the background
            Screen('FillRect', cfg.aperture.texture, cfg.color.background);

            % We let the stimulus through
            Screen('FillOval', cfg.aperture.texture, TRANSPARENT, ...
                   CenterRect( ...
                              [0, 0, repmat(cfg.screen.winRect(4), 1, 2)], ...
                              cfg.screen.winRect));

            % Then we add the position of the bar aperture

            % which one is the right and which one is the left??

            Screen('FillRect', cfg.aperture.texture, cfg.color.background, ...
                   [0, ...
                    0, ...
                    thisEvent.barPosPix - cfg.aperture.barWidthPix / 2, ...
                    cfg.screen.winRect(4)]);

            Screen('FillRect', cfg.aperture.texture, cfg.color.background, ...
                   [thisEvent.barPosPix + cfg.aperture.barWidthPix / 2, ...
                    0, ...
                    cfg.screen.winRect(3), ...
                    cfg.screen.winRect(4)]);

        otherwise

            error('unknown aperture type: %s.', cfg.aperture.type);

    end

end
