function test_suite = test_degToPix %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_degToPixBasic()

    fixation.width = 2;
    cfg.screen.ppd = 10;

    fixation = degToPix('width', fixation, cfg);

    expectedStruct.width = 2;
    expectedStruct.widthPix = 20;

    assertEqual(expectedStruct, fixation);

end
