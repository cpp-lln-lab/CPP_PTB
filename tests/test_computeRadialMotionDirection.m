function test_suite = test_computeRadialMotionDirection %#ok<*STOUT>
    %
    % (C) Copyright 2020 CPP_PTB developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_computeRadialMotionDirectionBasic()

    %% set up

    cfg.dot.matrixWidth = 100; % in pixels
    cfg.timing.eventDuration = 2;

    dots.direction = 666;
    dots.positions = [
                      100, 100 / 2; ... % middle of right side
                      100, 100; ... % top right corner
                      100 / 2, 100; ...
                      0, 100 / 2; ...
                      0, 0; ...
                      100 / 2, 0];

    angleMotion = computeRadialMotionDirection(dots.positions, cfg.dot.matrixWidth, dots);

    expectedDirection = [
                         0; ... right
                         45; ... up-right
                         90; ... up
                         180; ... left
                         -135; ... down left
                         -90]; % down

    %% test

    assertEqual(angleMotion, expectedDirection);

end
