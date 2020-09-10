function test_suite = test_reseedDots %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_reseedDotsBasic()

    cfg.screen.winWidth = 2000;

    cfg.design.motionType = 'radial';

    cfg.dot.matrixWidth = 50; % in pixels
    cfg.dot.number = 5;
    cfg.dot.sizePix = 20;
    cfg.dot.proportionKilledPerFrame = 0;

    cfg.fixation.widthPix = 20;

    dots.lifeTime = 100;
    dots.speedPixPerFrame = 3;
    dots.direction = 90;
    dots.isSignal = true(5, 1);

    dots.positions = [ ...
        49, 1; % OK
        490, 2043; % out of frame
        -104, 392; % out of frame
        492, 402; % OK
        1000, 1000; % on the fixation cross
        ];

    dots.time = [ ...
        6; ... OK
        4; ... OK
        56; ... OK
        300; ... % exceeded its life time
        50]; % OK

    dots = reseedDots(dots, cfg);

    reseeded = [ ...
        6;
        1;
        1;
        1;
        1];

    assertEqual(reseeded, dots.time);

end
