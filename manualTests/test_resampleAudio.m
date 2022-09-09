function test_suite = test_resampleAudio %#ok<*STOUT>
    %
    % (C) Copyright 2020 CPP_PTB developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_resampleAudio_basic()

    cfg.verbose = 1;
    cfg.audio.fs = 48000;

    stimFile = fullfile(pwd, '..', 'sounds', 'epiSequence2.wav');

    [audioData, audioFreq] = audioread(stimFile);

    stimStruct = struct( ...
                        'name', 'epiSequence2', ...
                        'audioData', audioData, ...
                        'audioFreq', audioFreq);

    stimStruct = resampleAudio(cfg, stimStruct);

end
