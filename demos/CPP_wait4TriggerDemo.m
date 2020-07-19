cd ..

% set up
cfg.testingDevice = 'scanner';
cfg.numTriggers = 4; 
cfg.triggerKey = 't';

% this field is not required but can be mentioned
cfg.MRI.repetitionTime = 3; 

% beginning of demo
KbName('UnifyKeyNames');

% press the key "t" to simulate triggers
wait4Trigger(cfg)