function test_suite = test_initDots %#ok<*STOUT>
    %
    % (C) Copyright 2020 CPP_PTB developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_initDotsBasic()

    %% set up

    % % Dot life time in seconds
    % cfg.dot.lifeTime
    % % Number of dots
    % cfg.dot.number
    % Proportion of coherent dots.
    % cfg.dot.coherence
    %
    % % Direction (an angle in degrees)
    % thisEvent.direction
    % % Speed expressed in pixels per frame
    % thisEvent.speed

    cfg.design.motionType = 'translation';
    cfg.dot.number = 10;
    cfg.dot.coherence = 1; % proportion
    cfg.dot.lifeTime = 0.250; % in seconds
    cfg.dot.matrixWidth = 50; % in pixels
    cfg.timing.eventDuration = 1; % in seconds
    cfg.screen.ifi = 0.01; % in seconds

    thisEvent.direction = 0;
    thisEvent.speedPix = 10;

    [dots] = initDots(cfg, thisEvent);

    %% Undeterministic output
    assertTrue(all(dots.positions(:) >= 0));
    assertTrue(all(dots.positions(:) <= 50));
    assertTrue(all(dots.time(:) >= 0));
    assertTrue(all(dots.time(:) <= 1 / 0.01));

    %% Deterministic output : data to test against
    expectedStructure.lifeTime = 25;
    expectedStructure.isSignal = ones(10, 1);
    expectedStructure.speeds = repmat([1 0], 10, 1) * 10;
    expectedStructure.speedPixPerFrame = 10;
    expectedStructure.direction = 0;

    % remove undeterministic output
    dots = rmfield(dots, 'time');
    dots = rmfield(dots, 'positions');

    %% test
    assertEqual(dots, expectedStructure);

end

function test_initDotsStatic()

    cfg.design.motionType = 'translation';
    cfg.dot.number = 10;
    cfg.dot.coherence = 1; % proportion
    cfg.dot.lifeTime = 0.250; % in seconds
    cfg.dot.matrixWidth = 50; % in pixels
    cfg.timing.eventDuration = 1; % in seconds
    cfg.screen.ifi = 0.01; % in seconds

    thisEvent.direction = -1;
    thisEvent.speedPix = 10;

    [dots] = initDots(cfg, thisEvent);

    % remove undeterministic output
    dots = rmfield(dots, 'time');
    dots = rmfield(dots, 'positions');

    %% data to test against
    expectedStructure.lifeTime = Inf;
    expectedStructure.isSignal = ones(10, 1);
    expectedStructure.speeds = zeros(10, 2);
    expectedStructure.speedPixPerFrame = 0;
    expectedStructure.direction = -1;

    %% test
    assertEqual(dots, expectedStructure);

end

function test_initDotsRadial()

    %% set up

    % % Dot life time in seconds
    % cfg.dot.lifeTime
    % % Number of dots
    % cfg.dot.number
    % Proportion of coherent dots.
    % cfg.dot.coherence
    %
    % % Direction (an angle in degrees)
    % thisEvent.direction
    % % Speed expressed in pixels per frame
    % thisEvent.speed

    cfg.design.motionType = 'radial';
    cfg.dot.number = 10;
    cfg.dot.coherence = 1; % proportion
    cfg.dot.lifeTime = 0.250; % in seconds
    cfg.dot.matrixWidth = 50; % in pixels
    cfg.timing.eventDuration = 1; % in seconds
    cfg.screen.ifi = 0.01; % in seconds

    thisEvent.direction = 666;
    thisEvent.speedPix = 10;

    [dots] = initDots(cfg, thisEvent);

    %% Deterministic output : data to test against
    expectedStructure.lifeTime = 25;
    expectedStructure.isSignal = ones(10, 1);
    expectedStructure.speedPixPerFrame = 10;
    expectedStructure.direction = 666;

    directionAllDots = setDotDirection( ...
                                       dots.positions, ...
                                       cfg, ...
                                       expectedStructure, ...
                                       expectedStructure.isSignal);
    [horVector, vertVector] = decomposeMotion(directionAllDots);
    if strcmp(cfg.design.motionType, 'radial')
        vertVector = vertVector * -1;
    end
    expectedStructure.speeds = [horVector, vertVector] * expectedStructure.speedPixPerFrame;

    % remove undeterministic output
    dots = rmfield(dots, 'time');
    dots = rmfield(dots, 'positions');

    %% test
    assertEqual(dots, expectedStructure);

end
