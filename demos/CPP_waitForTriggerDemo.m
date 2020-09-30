addpath(genpath(fullfile(pwd, '..', 'src')));

%%
cfg.testingDevice = 'mri';

cfg.mri.triggerNb = 2;

cfg.mri.triggerKey = 't';

KbName('UnifyKeyNames');

%%
% waitForTrigger(cfg);

%%
quietMode = false;
% waitForTrigger(cfg, [], quietMode);

%%
nbTriggersToWait = 5;
waitForTrigger(cfg, [], quietMode, nbTriggersToWait);
