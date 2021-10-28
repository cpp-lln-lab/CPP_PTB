%
% (C) Copyright 2020 CPP_PTB developers

% ensure that dot density contrast is not too low when we kill dots often enough

% There is an actual official unit test in the tests folder so this here is more
% to have the visualization turned on.

nbEvents = 100;
doPlot = true;

thisEvent.direction = 0; % degrees
thisEvent.speed = 1; % pix per frame

cfg.design.motionType = 'radial';

cfg.dot.coherence = 1; % proportion
cfg.dot.lifeTime = .1; % in seconds
cfg.dot.matrixWidth = 250; % in pixels
cfg.dot.proportionKilledPerFrame = 0;

cfg.timing.eventDuration = 1.8; % in seconds

relativeDensityContrast = dotMotionSimulation(cfg, thisEvent, nbEvents, doPlot);
