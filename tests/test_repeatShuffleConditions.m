function test_suite = test_repeatShuffleConditions %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_repeatShuffleConditionsBasic()

    baseVector = [1 2 3 4];
    nbRepeats = 2;

    shuffledRepeats = repeatShuffleConditions(baseVector, nbRepeats);

    % make sure no condition is repeated twice
    assertFalse(any(diff(shuffledRepeats, [], 2) == 0));
    assertTrue(length(shuffledRepeats) == (nbRepeats * length(baseVector)));

end
