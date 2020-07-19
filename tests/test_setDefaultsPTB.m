%% test basic cfg creation

% set up
cfgToTest =  struct(...
    'testingDevice', 'pc', ...
    'debug',  true, ...
    'testingTranspScreen',  true, ...
    'testingSmallScreen',  true, ...
    'backgroundColor',  [0 0 0], ...
    'text', struct('font', 'Courier New', 'size', 18, 'style', 1),  ...
    'monitorWidth', 42, ...
    'screenDistance', 134);

cfgToTest.keyboard.keyboard = [];
cfgToTest.keyboard.responseBox = [];
cfgToTest.keyboard.responseKey = {};
cfgToTest.keyboard.escapeKey = 'ESCAPE';


cfgToTest = orderfields(cfgToTest);

% test
cfg = setDefaultsPTB;
assert(isequal(cfg, cfgToTest))


%% test that values are not overwritten
clear cfg
cfg = struct('monitorWidth', 36);

cfgToTest.monitorWidth = 36;

cfg = setDefaultsPTB(cfg);
assert(isequal(cfg, cfgToTest))

cfgToTest.monitorWidth = 42;

%% test with audio init

% set up
cfgToTest.initAudio = 1;
cfgToTest.audio = struct(...
    'fs', 44800, ...
    'channels', 2, ...
    'initVolume', 1, ...
    'requestedLatency', 3, ...
    'repeat', 1, ...
    'startCue', 0, ...
    'waitForDevice', 1);

cfgToTest = orderfields(cfgToTest);

clear cfg
cfg.initAudio = 1;

% test
cfg = setDefaultsPTB(cfg);
assert(isequal(cfg, cfgToTest))