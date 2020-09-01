function test_suite = test_computeFOV %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_computeFOVBasic()

    cfg.screen.monitorWidth = 25;
    cfg.screen.monitorDistance = 50;

    FOV = computeFOV(cfg);

    expectedFOV = 28.072;

    assertElementsAlmostEqual(expectedFOV, FOV, 'absolute', 1e-3);

end

function test_computeFOVError()

    cfg.screen.monitorDistance = 1.2; % error as distance is most likely in meter

    assertExceptionThrown(@()computeFOV(cfg), ...
        'computeFOV:wrongDistanceToScreen');

end
