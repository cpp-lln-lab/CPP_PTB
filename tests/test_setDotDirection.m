function test_suite = test_setDotDirection %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_setDotDirectionInit()
    % create 5 coherent dots with direction == 362 (that should give 2 in the
    % end)
    % also creates additonal dots with random direction between 0 and 360

    nbDots = 10;

    cfg.dot.matrixWidth = 400;
    cfg.design.motionType = 'translation';

    dots.direction = 362;
    dots.isSignal = [true(5, 1); false(nbDots - 5, 1)];

    positions = generateNewDotPositions(cfg.dot.matrixWidth, numel(dots.isSignal));

    directionAllDots = setDotDirection(positions, cfg, dots, dots.isSignal);

    assertEqual(directionAllDots(1:5), 2 * ones(5, 1));
    assertGreaterThan(directionAllDots, zeros(size(directionAllDots)));
    assertLessThan(directionAllDots, 360 * ones(size(directionAllDots)));

end

function test_setDotDirectionReturn()
    % make sure that if the directions are already set it only changes that of
    % the noise dots
    % input has 4 signal dots with set directions also has additonal noise dots
    % with negative direction

    nbDots = 8;

    cfg.dot.matrixWidth = 400;
    cfg.design.motionType = 'translation';

    dots.direction = [ ...
                      [362; 2; -362; -2];  ...
                      -20 * ones(4, 1)];
    dots.isSignal = [true(4, 1); false(nbDots - 4, 1)];

    positions = generateNewDotPositions(cfg.dot.matrixWidth, numel(dots.isSignal));

    directionAllDots = setDotDirection(positions, cfg, dots, dots.isSignal);

    assertEqual(directionAllDots(1:4), [2 2 358 358]');
    assertGreaterThan(directionAllDots, zeros(size(directionAllDots)));
    assertLessThan(directionAllDots, 360 * ones(size(directionAllDots)));
    assertTrue(all(directionAllDots(5:end) ~= -20 * ones(4, 1)));

end
