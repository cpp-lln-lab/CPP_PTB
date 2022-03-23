%
% Small script to loop through all the devices
% and try to play some white noise on it to see which one actually works.
%
% (C) Copyright 2022 CPP_PTB developers

sca;
clear;
clc;

% init CPP PTB
rootDir = cd(fullfile(fileparts(mfilename('fullpath')), '..', '..'));
cpp_ptb;

% PsychPortAudio('Close');

cfg.audio.playbackMode = 1;
cfg.audio.channels = 2;
cfg.audio.requestedLatency = 3;

InitializePsychSound(1);

% Get a list of all the audio devices connected
audioDev = PsychPortAudio('GetDevices');

% Here we can decide to test just a few (value must be between 1 and numel(audioDev))
tmp = 10;

% Here we loop through all the devices and try to play some white noise on it
% to see which one actually works.
for idx = 10

    fprintf(1, '\n%i: %s\n', idx, audioDev(idx).DeviceName);

    cfg.audio.devIdx = audioDev(idx).DeviceIndex;

    % get device's sampling rate
    cfg.audio.fs = audioDev(idx).DefaultSampleRate;

    try
        cfg.audio.pahandle = PsychPortAudio('Open', ...
                                            cfg.audio.devIdx, ...
                                            cfg.audio.playbackMode, ...
                                            cfg.audio.requestedLatency, ...
                                            cfg.audio.fs, ...
                                            cfg.audio.channels);

        clear sound;
        sound = rand(cfg.audio.channels, cfg.audio.fs);

        PsychPortAudio('FillBuffer', cfg.audio.pahandle, sound);
        PsychPortAudio('Start', cfg.audio.pahandle);

        WaitSecs(1.5);

        PsychPortAudio('Close');

        WaitSecs(1);
    catch
    end

    pressSpaceForMe;

end
