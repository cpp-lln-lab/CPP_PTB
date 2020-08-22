function loadAndPlayEpiBackgroundSound(cfg)

    soundFile = fullfile(fileparts(mfilename('fullpath')), ...
        '..', '..', ...
        'sounds', 'epiSequence2.wav');
    
    [audiodata, infreq] = psychwavread(soundFile);
    
    size(audiodata)
    
    mode = 1;
    nbChannels = 2;
    selectChannels = [1, 2]; % select channel 3 and 4 to play sound
    
    cfg.audio.epiPahandle = PsychPortAudio('OpenSlave', cfg.audio.pahandle, ...
        mode, nbChannels, selectChannels);
    
    fprintf('Resampling EPI sound to from %i Hz to %i Hz... ', infreq, cfg.audio.fs);
    audiodata = resample(audiodata, cfg.audio.fs, infreq);
    
    % make sure the data has the right dimension
    audiodata = repmat(transpose(audiodata), cfg.audio.channels, 1);

%     bufferhandle = PsychPortAudio('CreateBuffer', cfg.audio.pahandle, audiodata);
    
    PsychPortAudio('FillBuffer', cfg.audio.epiPahandle, audiodata);
    
    PsychPortAudio('Start', cfg.audio.epiPahandle, 0);
    
    
end