% set up
cfg.testingDevice = 'scanner';
cfg.numTriggers = 4; 
cfg.triggerKey = 't';

% this field is not required but can be mentioned
cfg.MRI.repetitionTime = 3; 

% add parent directory to the path (to make sure we can access the CPP_PTB
% functions)
addpath(fullfile(pwd, '..')) 

% beginning of demo
KbName('UnifyKeyNames');

% press the key "t" to simulate triggers
wait4Trigger(cfg)