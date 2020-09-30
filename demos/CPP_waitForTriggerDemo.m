% add parent/src directory to the path (to make sure we can access the CPP_PTB functions)

addpath(genpath(fullfile(pwd, '..', 'src')));

cfg.mri.triggerNb = 5;

cfg.mri.triggerKey = 't';

KbName('UnifyKeyNames');

%%
% waitForTrigger(cfg);

%%
quietMode = false;
% waitForTrigger(cfg, [], quietMode);

%%
waitForTrigger(cfg, [], quietMode, cfg.mri.triggerNb);
