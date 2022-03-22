sca
clear
clc
% PsychPortAudio('Close');

cfg.audio.playbackMode = 1;
cfg.audio.channels = 2;
cfg.audio.requestedLatency = 3;

InitializePsychSound(1);
audioDev = PsychPortAudio('GetDevices');

% tmp = [2 3 9];

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
        
        clear sound
        sound = rand(cfg.audio.channels, cfg.audio.fs);
        
        PsychPortAudio('FillBuffer', cfg.audio.pahandle, sound);
        PsychPortAudio('Start', cfg.audio.pahandle);
        
        WaitSecs(1.5);
        
        PsychPortAudio('Close');
        
        WaitSecs(1);
    catch
    end
    
     pressSpaceForMe 
    
end
