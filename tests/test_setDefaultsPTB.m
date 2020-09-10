function test_suite = test_setDefaultsPTB %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_setDefaultsPtbBasic()

    % set up
    cfg = setDefaultsPTB;

    % test data
    expectedCfg = returnExpectedCFG();

    % test
    assertEqual(expectedCfg, cfg);

end

function test_setDefaultsPtbOverwrite()

    % set up
    cfg.screen.monitorWidth = 36;
    cfg = setDefaultsPTB(cfg);

    % test data
    expectedCfg = returnExpectedCFG();
    expectedCfg.screen.monitorWidth = 36;

    % test
    assertEqual(expectedCfg, cfg);

end

function test_setDefaultsPtbAudio()

    % set up
    cfg.audio.do = 1;
    cfg = setDefaultsPTB(cfg);

    % test data
    expectedCfg = returnExpectedCFG();
    expectedCfg.audio = struct( ...
        'do', true, ...
        'fs', 44800, ...
        'channels', 2, ...
        'initVolume', 1, ...
        'requestedLatency', 3, ...
        'repeat', 1, ...
        'startCue', 0, ...
        'waitForDevice', 1);

    % test
    assertEqual(expectedCfg, cfg);

end

function expectedCFG = returnExpectedCFG()

    expectedCFG =  struct( ...
        'testingDevice', 'pc', ...
        'debug',  struct('do', true, 'transpWin',  true, 'smallWin',  true), ...
        'color',  struct( ...
        'background', [0 0 0]), ...
        'text', struct('font', 'Courier New', 'size', 18, 'style', 1));

    expectedCFG.screen.monitorWidth = 42;
    expectedCFG.screen.monitorDistance = 134;
    expectedCFG.screen.resolution = {[], [], []};

    % fixation cross or dot
    expectedCFG.fixation.type = 'cross';
    expectedCFG.fixation.xDisplacement = 0;
    expectedCFG.fixation.yDisplacement = 0;
    expectedCFG.fixation.color = [255 255 255];
    expectedCFG.fixation.width = 1;
    expectedCFG.fixation.lineWidthPix = 5;

    % define visual apperture field
    expectedCFG.aperture.type = 'none';

    expectedCFG.keyboard.keyboard = [];
    expectedCFG.keyboard.responseBox = [];
    expectedCFG.keyboard.responseKey = {};
    expectedCFG.keyboard.escapeKey = 'ESCAPE';

end
