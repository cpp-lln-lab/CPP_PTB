
% ensure that dog homogenity is not too low when we kill dots often enough

nbEvents = 1;
doPlot = true;

thisEvent.direction = -666; % degrees
thisEvent.speed = 1; % pix per frame

cfg.design.motionType = 'radial';

cfg.dot.coherence = 1; % proportion
cfg.dot.lifeTime = Inf; % in seconds
cfg.dot.matrixWidth = 1000; % in pixels
cfg.dot.proportionKilledPerFrame = 0;
cfg.dot.number = 10;

cfg.timing.eventDuration = 100; % in seconds


relativeDensityContrast = dotMotionSimulation(cfg, thisEvent, nbEvents, doPlot);



