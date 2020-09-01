function test_suite = test_setDotDirection %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_setDotDirectionBasic()
    % create 5 coherent dots with direction == 362 (that should give 2 in the
    % end)
    % also creates 955 additonal dots with random direction between 0 and 360

    cfg.dot.number = 1000;
    cfg.design.motionType = 'translation';
    dots.direction = 362;

    dots.isSignal = [true(5, 1); false(1000 - 5, 1)];

    dots = setDotDirection(cfg, dots);

    assertTrue(all(dots.directionAllDots(1:5) == 2 * ones(5, 1)));
    assertTrue(all(dots.directionAllDots >= 0));
    assertTrue(all(dots.directionAllDots <= 360));

end
