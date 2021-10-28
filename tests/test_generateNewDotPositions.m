function test_suite = test_generateNewDotPositions %#ok<*STOUT>
    %
    % (C) Copyright 2020 CPP_PTB developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_generateNewDotPositionsBasic()

    dotMatrixWidth = 400;
    dotNumber = 200;

    newPositions = generateNewDotPositions(dotMatrixWidth, dotNumber);

    assertEqual([200, 2], size(newPositions));

    assertTrue(all(all([newPositions(:) <= 400, newPositions(:) >= 0])));

end
