cd ..

cfg.device = 'scanner';
cfg.MRI.repetitionTime = 3;
cfg.numTriggers = 4; 
cfg.triggerKey = 'space';

KbName('UnifyKeyNames');

wait4Trigger(cfg)