function test_suite = test_reseedDots %#ok<*STOUT>
    %
    % (C) Copyright 2020 CPP_PTB developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_reseedDotsBasic()

    dotNb = 5;

    cfg.design.motionType = 'translation';
    cfg.timing.eventDuration = 1; % in seconds
    cfg.screen.ifi = 0.01; % in seconds

    cfg.dot.matrixWidth = 1000; % in pixels
    cfg.dot.number = dotNb;
    cfg.dot.sizePix = 20;
    cfg.dot.proportionKilledPerFrame = 0;

    cfg.fixation.widthPix = 5;

    dots.lifeTime = 100;
    dots.speedPixPerFrame = 3;
    dots.direction = 90;
    dots.isSignal = true(dotNb, 1);
    dots.speeds = ones(dotNb, 2);

    dots.positions = [ ...
                      300, 10  % OK
                      750, 1010  % out of frame
                      -1040, 50  % out of frame
                      300, 300  % OK
                      500, 500  % on the fixation cross
                     ];

    originalTime = [ ...
                    6; ... OK
                    4; ... OK
                    56; ... OK
                    300; ... % exceeded its life time
                    50]; % OK
    dots.time = originalTime;

    dots = reseedDots(dots, cfg);

    assertEqual(dots.time(1), originalTime(1));
    assertTrue(all(dots.time(2:end) ~= originalTime(2:end)));

end
