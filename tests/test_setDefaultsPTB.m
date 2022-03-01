function test_suite = test_setDefaultsPTB %#ok<*STOUT>
    %
    % (C) Copyright 2020 CPP_PTB developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_setDefaultsPtb_basic()

    % set up
    cfg = checkDefaultsPTB();

    % test data
    expectedCfg = cppPtbDefaults('all');
    expectedCfg.eyeTracker.do = false;
    expectedCfg.skipSyncTests = 2;

    % test
    assertEqual(expectedCfg, cfg);

end

function test_setDefaultsPtb_no_debug()

    % set up
    cfg = checkDefaultsPTB();

    % test data
    expectedCfg = cppPtbDefaults('all');
    expectedCfg.eyeTracker.do = false;
    expectedCfg.skipSyncTests = 2;

    % test
    assertEqual(expectedCfg, cfg);

end

function test_setDefaultsPtb_overwrite()

    % set up
    cfg.screen.monitorWidth = 36;
    cfg = checkDefaultsPTB(cfg);

    % test data
    expectedCfg = cppPtbDefaults('all');
    expectedCfg.screen.monitorWidth = 36;
    expectedCfg.eyeTracker.do = false;
    expectedCfg.skipSyncTests = 2;

    % test
    assertEqual(expectedCfg, cfg);

end

function test_setDefaultsPtb_audio()

    % set up
    cfg.audio.do = 1;
    cfg = checkDefaultsPTB(cfg);

    % test data
    expectedCfg = cppPtbDefaults('all');
    expectedCfg.audio = struct('do', true, ...
                               'devIdx', [], ...
                               'playbackMode', 1, ...
                               'fs', 44100, ...
                               'channels', 2, ...
                               'initVolume', 1, ...
                               'requestedLatency', 3, ...
                               'repeat', 1, ...
                               'startCue', 0, ...
                               'waitForDevice', 1);

    expectedCfg.audio.pushSize  = expectedCfg.audio.fs * 0.010;

    expectedCfg.audio.requestOffsetTime = 1;
    expectedCfg.audio.reqsSampleOffset = expectedCfg.audio.requestOffsetTime * ...
                                         expectedCfg.audio.fs;

    expectedCfg.eyeTracker.do = false;
    expectedCfg.skipSyncTests = 2;

    % test
    assertEqual(expectedCfg, cfg);

end

function test_setDefaultsPtb_mri()

    % set up
    cfg.testingDevice = 'mri';
    cfg = checkDefaultsPTB(cfg);

    % test data
    expectedCfg = cppPtbDefaults('all');
    expectedCfg.testingDevice = 'mri';
    expectedCfg.bids.mri.RepetitionTime = [];
    expectedCfg.pacedByTriggers.do = false;
    expectedCfg.eyeTracker.do = false;
    expectedCfg.skipSyncTests = 2;

    % test
    assertEqual(expectedCfg, cfg);

end
