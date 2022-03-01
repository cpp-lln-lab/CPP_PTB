function cfg = checkDefaultsPTB(cfg)
    % Set some defaults values if none have been set before.
    %
    % USAGE::
    %
    %   cfg = checkDefaultsPTB(cfg)
    %
    % :param cfg:
    % :type cfg: structure
    %
    % :returns: - :cfg: (structure)
    %
    % (C) Copyright 2020 CPP_PTB developers

    if nargin < 1
        cfg = struct;
    end

    fieldsToSet = cppPtbDefaults('all');

    if isfield(cfg, 'audio') && cfg.audio.do

        fieldsToSet.audio.devIdx = [];
        fieldsToSet.audio.playbackMode = 1;

        fieldsToSet.audio.fs = 44100;
        fieldsToSet.audio.channels = 2;
        fieldsToSet.audio.initVolume = 1;
        fieldsToSet.audio.requestedLatency = 3;

        % playing parameters
        % sound repetition
        fieldsToSet.audio.repeat = 1;

        % Start immediately (0 = immediately)
        fieldsToSet.audio.startCue = 0;

        % Should we wait for the device to really start?
        fieldsToSet.audio.waitForDevice = 1;

        fieldsToSet.audio.pushSize  = fieldsToSet.audio.fs * 0.010; % ! push N ms only

        fieldsToSet.audio.requestOffsetTime = 1; % offset 1 sec
        fieldsToSet.audio.reqsSampleOffset = fieldsToSet.audio.requestOffsetTime * ...
                                             fieldsToSet.audio.fs;

    end

    if isfield(cfg, 'eyeTracker') && cfg.eyeTracker.do
        % Calibration environment
        fieldsToSet.eyeTracker = cppPtbDefaults('eyeTracker');
    end

    if isfield(cfg, 'testingDevice') && strcmpi(cfg.testingDevice, 'mri')
        fieldsToSet.bids.mri.RepetitionTime = [];
        fieldsToSet.pacedByTriggers.do = false;
    end

    cfg = setDefaultFields(cfg, fieldsToSet);

    %% checks
    if cfg.debug.do
        cfg.eyeTracker.do = false;
        cfg.skipSyncTests = 2;
    end

    if cfg.skipSyncTests == false
        cfg.skipSyncTests = 0;
    elseif cfg.skipSyncTests == true
        cfg.skipSyncTests = 1;
    end
    
    if ~ismember(cfg.fixation.type, {'cross', 'dot', 'bestFixation'})
      error('cfg.fixation.type must be one of ''cross'', ''dot'', ''bestFixation''');
    end

    % sort fields alphabetically
    cfg = orderfields(cfg);

end
