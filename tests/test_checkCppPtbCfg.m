function test_suite = test_checkCppPtbCfg %#ok<*STOUT>
    %
    % (C) Copyright 2020 CPP_PTB developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_checkCppPtbCfg_basic()

    % set up
    cfg = checkCppPtbCfg();

    % test data
    expected = cppPtbDefaults('all');
    expected.eyeTracker.do = false;
    expected.debug.do = 1;
    expected.skipSyncTests = 1;
    expected.hideCursor = false;

    % test
    checkAllFields(cfg, expected);

end

function test_setDefaultsPtb_no_debug()

    % set up
    cfg.debug.do = false;
    cfg = checkCppPtbCfg(cfg);

    % test data
    expected = cppPtbDefaults('all');
    expected.debug.do = 0;
    expected.skipSyncTests = 0;
    expected.hideCursor = true;

    % test
    checkAllFields(cfg, expected);

end

function test_setDefaultsPtb_overwrite()

    % set up
    cfg.screen.monitorWidth = 36;
    cfg = checkCppPtbCfg(cfg);

    % test data
    expected = cppPtbDefaults('all');
    expected.screen.monitorWidth = 36;
    expected.eyeTracker.do = false;
    expected.skipSyncTests = 1;
    expected.hideCursor = false;

    % test
    checkAllFields(cfg, expected);

end

function test_setDefaultsPtb_audio()

    % set up
    cfg.audio.do = 1;
    cfg = checkCppPtbCfg(cfg);

    % test data
    expected = cppPtbDefaults('all');
    expected.audio = struct('do', true, ...
                            'devIdx', [], ...
                            'playbackMode', 1, ...
                            'fs', 44100, ...
                            'channels', 2, ...
                            'initVolume', 1, ...
                            'requestedLatency', 3, ...
                            'repeat', 1, ...
                            'startCue', 0, ...
                            'waitForDevice', 1);

    expected.audio.pushSize  = expected.audio.fs * 0.010;

    expected.audio.requestOffsetTime = 1;
    expected.audio.reqsSampleOffset = expected.audio.requestOffsetTime * ...
                                         expected.audio.fs;

    expected.eyeTracker.do = false;
    expected.skipSyncTests = 1;
    expected.hideCursor = false;

    % test
    checkAllFields(cfg, expected);

end

function test_setDefaultsPtb_mri()

    % set up
    cfg.testingDevice = 'mri';
    cfg = checkCppPtbCfg(cfg);

    % test data
    expected = cppPtbDefaults('all');
    expected.testingDevice = 'mri';
    expected.bids.mri.RepetitionTime = [];
    expected.pacedByTriggers.do = false;
    expected.eyeTracker.do = false;
    expected.skipSyncTests = 1;
    expected.hideCursor = false;

    % test
    checkAllFields(cfg, expected);

end

function checkAllFields(cfg, expected)
    fields = fieldnames(expected);
    for i = 1:numel(fields)
        %         fields{i}
        assertEqual(cfg.(fields{i}), expected.(fields{i}));
    end
end
