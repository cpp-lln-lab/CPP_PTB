function test_suite = test_seedDots %#ok<*STOUT>
    %
    % (C) Copyright 2020 CPP_PTB developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_seedDotsBasic()

    %% set up

    cfg.dot.matrixWidth = 400;
    cfg.design.motionType = 'translation';
    cfg.timing.eventDuration = 1; % in seconds
    cfg.screen.ifi = 0.01; % in seconds

    nbDots = 10;
    isSignal = [true(5, 1); false(nbDots - 5, 1)];

    dots.direction = 0;
    dots.speedPixPerFrame = 10;

    [positions, speeds, time] = seedDots(dots, cfg, isSignal);

    %% Deterministic output
    assertEqual(size(positions), [nbDots, 2]);
    assertTrue(all(all([ ...
                        positions(:) <= cfg.dot.matrixWidth, ...
                        positions(:) >= 0])));

    assertTrue(all(time(:) >= 0));
    assertTrue(all(time(:) <= 1 / 0.01));

    assertEqual(speeds(1:5, :), repmat([10 0], 5, 1));

end
