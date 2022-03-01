function value = defaultCFG()
    %
    % (C) Copyright 2022 CPP_PTB developers

    value =  struct('testingDevice', 'pc', ...
                    'debug',  struct('do', true, ...
                                     'transpWin',  true, ...
                                     'smallWin',  true), ...
                    'color',  struct('background', [0 0 0]), ...
                    'text', struct('font', 'Courier New', 'size', 18, 'style', 1));

    value.screen.monitorWidth = 42;
    value.screen.monitorDistance = 134;
    value.screen.resolution = {[], [], []};

    value.skipSyncTests = 0;

    % fixation cross or dot
    value.fixation.type = 'cross';
    value.fixation.xDisplacement = 0;
    value.fixation.yDisplacement = 0;
    value.fixation.color = [255 255 255];
    value.fixation.width = 1;
    value.fixation.lineWidthPix = 5;

    % define visual apperture field
    value.aperture.type = 'none';

    value.keyboard.keyboard = [];
    value.keyboard.responseBox = [];
    value.keyboard.responseKey = {};
    value.keyboard.escapeKey = 'ESCAPE';

end
