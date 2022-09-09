function stimStruct = resampleAudio(cfg, stimStruct)
    %
    % resample a sound to the requested sampling rate
    %
    % USAGE::
    %
    %       stimStruct = resampleAudio(cfg, stimStruct)
    %
    % :param cfg: Configuration. See ``checkCppPtbCfg()``.
    % :type cfg: structure
    %
    % :type stimStruct: structure
    % :param stimStruct: structure containing the stimuli with the following fields:
    %                      - ``name`` name of the stimulus
    %                      - ``audfreq`` sampling rate of the audio stim
    %                      - ``audioData`` data of the audio stim
    %
    %
    %
    % EXAMPLE:
    %
    % .. code-block:: matlab
    %
    %       cfg.verbose = 1;
    %       cfg.audio.fs = 48000;
    %
    %       stimFile = fullfile(pwd, '..', 'sounds', 'epiSequence2.wav');
    %
    %       [audioData, audioFreq] = audioread(stimFile);
    %
    %       stimStruct = struct(...
    %         'name', 'epiSequence2', ...
    %         'audioData', audioData, ...
    %         'audioFreq', audioFreq);
    %
    %       stimStruct = resampleAudio(cfg, stimStruct);
    %
    % (C) Copyright 2022 Remi Gau

    if stimStruct.audioFreq ~= cfg.audio.fs

        if cfg.verbose
            fprintf('Resampling %s from %i Hz to %i Hz... ', ...
                    stimStruct.name, ...
                    stimStruct.audioFreq, ...
                    cfg.audio.fs);
        end

        stimStruct.audioData = resample(stimStruct.audioData, ...
                                        cfg.audio.fs, ...
                                        stimStruct.audioFreq);
    end

end
