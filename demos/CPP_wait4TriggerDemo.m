cd ..;

cfg.device = 'Scanner';

cfg.numTriggers = 4;

cfg.triggerKey = 'space';

KbName('UnifyKeyNames');

wait4Trigger(cfg);
