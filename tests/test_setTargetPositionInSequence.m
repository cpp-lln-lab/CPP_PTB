function test_suite = test_setTargetPositionInSequence %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_setTargetPositionInSequenceBasic()

    seqLength = 12;
    nbTarget = 3;
    forbiddenPos = [1 5 10];

    % Create a hundred draws of targer positiona and ensure that
    % - the forbidden position are never drawn
    % - the interval between target is superior to 1
    for i = 1:100
        chosenPositions(i, :) = setTargetPositionInSequence(seqLength, nbTarget, forbiddenPos);
    end

    assertFalse(any(ismember(chosenPositions(:), forbiddenPos)));

    interval = abs(diff(chosenPositions, [], 2));
    assertTrue(all(interval(:) > 1));

end
