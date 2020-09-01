function test_suite = test_initDots %#ok<*STOUT>
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
    cfg.screen.winWidth = 2000; % in pixels
    cfg.timing.eventDuration = 1; % in seconds
    cfg.screen.ifi = 0.01; % in seconds

    thisEvent.direction = 0;
    thisEvent.speed = 10;

    [dots] = initDots(cfg, thisEvent);

    %% Undeterministic ouput
    assertTrue(all(dots.positions(:) >= 0));
    assertTrue(all(dots.positions(:) <= 2000));
    assertTrue(all(dots.time(:) >= 0));
    assertTrue(all(dots.time(:) <= 1 / 0.01));

    %% Deterministic output : data to test against
    expectedStructure.lifeTime = 25;
    expectedStructure.isSignal = ones(10, 1);
    expectedStructure.speeds = repmat([1 0], 10, 1) * 10;
    expectedStructure.speedPixPerFrame = 10;
    expectedStructure.direction = zeros(10, 1);
    expectedStructure.directionAllDots = zeros(10, 1);

    % remove undeterministic output
    dots = rmfield(dots, 'time');
    dots = rmfield(dots, 'positions');

    %% test
    assertEqual(expectedStructure, dots);

end

function test_initDotsStatic()

    cfg.design.motionType = 'translation';
    cfg.dot.number = 10;
    cfg.dot.coherence = 1; % proportion
    cfg.dot.lifeTime = 0.250; % in seconds
    cfg.dot.matrixWidth = 50; % in pixels
    cfg.screen.winWidth = 2000; % in pixels
    cfg.timing.eventDuration = 1; % in seconds
    cfg.screen.ifi = 0.01; % in seconds

    thisEvent.direction = -1;
    thisEvent.speed = 10;

    [dots] = initDots(cfg, thisEvent);

    % remove undeterministic output
    dots = rmfield(dots, 'time');
    dots = rmfield(dots, 'positions');

    %% data to test against
    expectedStructure.lifeTime = Inf;
    expectedStructure.isSignal = ones(10, 1);
    expectedStructure.speeds = zeros(10, 2);
    expectedStructure.speedPixPerFrame = 0;
    expectedStructure.direction = -1 * ones(10, 1);
    expectedStructure.directionAllDots = -1 * ones(10, 1);

    %% test
    assertEqual(expectedStructure, dots);

end

function test_initDotsRadial()

    cfg.design.motionType = 'radial';
    cfg.dot.number = 10;
    cfg.dot.coherence = 1; % proportion
    cfg.dot.lifeTime = 0.250; % in seconds
    cfg.dot.matrixWidth = 50; % in pixels
    cfg.screen.winWidth = 2000; % in pixels
    cfg.timing.eventDuration = 1; % in seconds
    cfg.screen.ifi = 0.01; % in seconds

    thisEvent.direction = 666; % outward motion
    thisEvent.speed = 10;

    [dots] = initDots(cfg, thisEvent);

    %% data to test against
    XY = dots.positions - 2000 / 2;
    angle = cart2pol(XY(:, 1), XY(:, 2));
    angle = angle / pi * 180;
    [horVector, vertVector] = decomposeMotion(angle);
    speeds = [horVector, vertVector] * 10;

    %% test
    %     assertEqual(speeds, dots.speeds);

end
