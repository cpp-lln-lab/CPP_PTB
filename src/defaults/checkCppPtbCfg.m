function cfg = checkCppPtbCfg(cfg)
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
      fieldsToSet.audio = cppPtbDefaults('audio');
    end

    if isfield(cfg, 'eyeTracker') && cfg.eyeTracker.do
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
