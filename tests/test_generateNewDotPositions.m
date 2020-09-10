function test_suite = test_generateNewDotPositions %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_generateNewDotPositionsBasic()

    cfg.dot.matrixWidth = 400;
    dotNumber = 200;

    newPositions = generateNewDotPositions(cfg, dotNumber);

    assertEqual([200, 2], size(newPositions));

    assertTrue(all(all([newPositions(:) <= 400, newPositions(:) >= 0])));

end
