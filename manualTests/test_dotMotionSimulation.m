function test_suite = test_dotMotionSimulation %#ok<*STOUT>
    %
    % (C) Copyright 2020 CPP_PTB developers
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_dotMotionSimulationStatic()

    nbEvents = 1;
    doPlot = false;

    thisEvent.direction = -1; % degrees
    thisEvent.speedPix = 1; % pix per frame

    cfg.design.motionType = 'translation';
    cfg.dot.coherence = 1; % proportion
    cfg.dot.lifeTime = .5; % in seconds
    cfg.dot.matrixWidth = 250; % in pixels
    cfg.dot.proportionKilledPerFrame = 0;
    cfg.timing.eventDuration = 1.8; % in seconds

    relativeDensityContrast = dotMotionSimulation(cfg, thisEvent, nbEvents, doPlot);

end

function test_dotMotionSimulationTranslation()
    % ensure that dog homogenity is not too low when we kill dots often enough

    nbEvents = 500;
    doPlot = false;

    thisEvent.direction = 0; % degrees
    thisEvent.speedPix = 1; % pix per frame

    cfg.design.motionType = 'translation';
    cfg.dot.coherence = 1; % proportion
    cfg.dot.lifeTime = .1; % in seconds
    cfg.dot.matrixWidth = 250; % in pixels
    cfg.dot.proportionKilledPerFrame = 0;
    cfg.timing.eventDuration = 1.8; % in seconds

    relativeDensityContrast = dotMotionSimulation(cfg, thisEvent, nbEvents, doPlot);

    assertLessThan(relativeDensityContrast, 0.5);

end
