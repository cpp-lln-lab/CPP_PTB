function test_suite = test_decomposeMotion %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_decomposeMotionBasic()

    [horVector, vertVector] = decomposeMotion(0);
    expectedOutput = [1, 0];
    assertEqual(expectedOutput, [horVector, vertVector]);

    [horVector, vertVector] = decomposeMotion(90);
    expectedOutput = [0, -1];
    assertElementsAlmostEqual(expectedOutput, [horVector, vertVector]);

    [horVector, vertVector] = decomposeMotion(180);
    expectedOutput = [-1, 0];
    assertElementsAlmostEqual(expectedOutput, [horVector, vertVector]);

    [horVector, vertVector] = decomposeMotion(270);
    expectedOutput = [0, 1];
    assertElementsAlmostEqual(expectedOutput, [horVector, vertVector]);

    [horVector, vertVector] = decomposeMotion(360);
    expectedOutput = [1, 0];
    assertElementsAlmostEqual(expectedOutput, [horVector, vertVector]);

end
