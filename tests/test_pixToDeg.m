function test_suite = test_pixToDeg %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_pixToDegBasic()

    fixation.widthPix = 20;
    cfg.screen.ppd = 10;

    fixation = pixToDeg('widthPix', fixation, cfg);

    expectedStruct.widthDegVA = 2;
    expectedStruct.widthPix = 20;

    assertEqual(expectedStruct, fixation);

end
