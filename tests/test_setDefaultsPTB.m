function test_setDefaultsPTB()
    
    %% test basic cfg creation
    
    % test data
    expectedCFG = returnExpectedCFG();
    
    % test
    cfg = setDefaultsPTB;
    testSubFields(expectedCFG, cfg)
    
    %% test that values are not overwritten
    
    clear cfg
    
    % test data
    expectedCFG = returnExpectedCFG();
    expectedCFG.screen.monitorWidth = 36;
    
    % set up
    cfg.screen.monitorWidth = 36;
    
    % test
    cfg = setDefaultsPTB(cfg);
    testSubFields(expectedCFG, cfg)
    
    %% test with audio init
    
    clear cfg
    
    % test data
    expectedCFG = returnExpectedCFG();
    expectedCFG.audio = struct( ...
        'do', true, ...
        'fs', 44800, ...
        'channels', 2, ...
        'initVolume', 1, ...
        'requestedLatency', 3, ...
        'repeat', 1, ...
        'startCue', 0, ...
        'waitForDevice', 1);
    
    % set up
    cfg.audio.do = 1;
    
    % test
    cfg = setDefaultsPTB(cfg);
    testSubFields(expectedCFG, cfg)
    
    
end


function expectedCFG = returnExpectedCFG()
    
    expectedCFG =  struct( ...
        'testingDevice', 'pc', ...
        'debug',  struct('do', true, 'transpWin',  true, 'smallWin',  true), ...
        'color',  struct( ...
        'background', [0 0 0]), ...
        'text', struct('font', 'Courier New', 'size', 18, 'style', 1),  ...
        'screen', struct( ...
        'monitorWidth', 42, ...
        'monitorDistance', 134));
    
    expectedCFG.keyboard.keyboard = [];
    expectedCFG.keyboard.responseBox = [];
    expectedCFG.keyboard.responseKey = {};
    expectedCFG.keyboard.escapeKey = 'ESCAPE';
    
end

function testSubFields(expectedStructure, cfg)
    % check that that the structures match
    % if it fails it check from which subfield the error comes from

    try

        assert(isequal(expectedStructure, cfg));

    catch ME

        if isstruct(expectedStructure)

            names = fieldnames(expectedStructure);

            for i = 1:numel(names)

                disp(names{i});
                testSubFields(expectedStructure.(names{i}), cfg.(names{i}));

            end

        end

        expectedStructure;
        cfg;

        rethrow(ME);
    end
end
