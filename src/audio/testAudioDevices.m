function testAudioDevices(cfg, deviceIndices)
    %
    % Loops through audio devices and tries to play 1 second white noise
    %
    % See also: listAudioDevices
    %
    %
    % (C) Copyright 2022 Remi Gau

    more off;

    PsychPortAudio('Close');

    if nargin < 1 || isempty(cfg)

        cfg.audio.playbackMode = 1;
        cfg.audio.channels = 2;
        cfg.audio.requestedLatency = 3;

    end

    InitializePsychSound(1);

    audioDev = PsychPortAudio('GetDevices');

    if nargin < 2 || isempty(deviceIndices)
        deviceIndices = audioDev.DeviceIndex;
    end

    fprintf(1, '\n%s', repmat('-', 1, 100));
    fprintf(1, '\n\nTesting audio devices: %i', deviceIndices);

    for i = 1:numel(deviceIndices)

        this_idx = find([audioDev.DeviceIndex] == deviceIndices(i));

        cfg.audio.devName = audioDev(this_idx).DeviceName;
        cfg.audio.devIdx = audioDev(this_idx).DeviceIndex;
        cfg.audio.fs = audioDev(this_idx).DefaultSampleRate;

        fprintf(1, '\n\nDEVICE\n\tname: %s\n\tindex: %i\n\tdefault sample rate: %i\n\n', ...
                cfg.audio.devName, ...
                cfg.audio.devIdx, ...
                cfg.audio.fs);

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

            WaitSecs(1);

            PsychPortAudio('Close');

            WaitSecs(1);

            fprintf(1, '\n--- SUCCESS ---\n\n');

        catch

            fprintf(1, '\n--- FAILED ---\n\n');

        end

    end

end
