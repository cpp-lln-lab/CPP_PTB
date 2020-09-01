function test_suite = test_initFixation %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_initFixationBasic()

    cfg.screen.ppd = 10;
    cfg.fixation.type = 'cross';
    cfg.fixation.width  = 1;
    cfg.fixation.xDisplacement = 1;
    cfg.fixation.yDisplacement = 1;

    cfg = initFixation(cfg);

    cfg.fixation;

    expectedStruct.screen.ppd = 10;
    expectedStruct.fixation.type = 'cross';
    expectedStruct.fixation.width = 1;
    expectedStruct.fixation.xDisplacement = 1;
    expectedStruct.fixation.yDisplacement = 1;
    expectedStruct.fixation.widthPix = 10;
    expectedStruct.fixation.xDisplacementPix = 10;
    expectedStruct.fixation.yDisplacementPix = 10;
    expectedStruct.fixation.xCoords = [5 15 10 10];
    expectedStruct.fixation.yCoords = [10 10 5 15];
    expectedStruct.fixation.allCoords = [5 15 10 10; 10 10 5 15];

    assertEqual(expectedStruct, cfg);

end

function test_initFixationBestFixation()

    cfg.screen.ppd = 10;
    cfg.screen.center = [100 100];
    cfg.fixation.type = 'bestFixation';
    cfg.fixation.width  = 1;
    cfg.fixation.xDisplacement = 1;
    cfg.fixation.yDisplacement = 1;

    cfg = initFixation(cfg);

    cfg.fixation;

    expectedStruct.screen.ppd = 10;
    expectedStruct.screen.center = [100 100];
    expectedStruct.fixation.type = 'bestFixation';
    expectedStruct.fixation.width = 1;
    expectedStruct.fixation.xDisplacement = 1;
    expectedStruct.fixation.yDisplacement = 1;
    expectedStruct.fixation.widthPix = 10;
    expectedStruct.fixation.xDisplacementPix = 10;
    expectedStruct.fixation.yDisplacementPix = 10;
    expectedStruct.fixation.xCoords = [5 15 10 10];
    expectedStruct.fixation.yCoords = [10 10 5 15];
    expectedStruct.fixation.allCoords = [5 15 10 10; 10 10 5 15];
    expectedStruct.fixation.outerOval = [95 95 105 105];
    expectedStruct.fixation.innerOval = [100 - 10 / 6, 100 - 10 / 6, 100 + 10 / 6, 100 + 10 / 6];

    assertEqual(expectedStruct, cfg);

end
