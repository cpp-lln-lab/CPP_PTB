function cpp_ptb(varargin)
    %
    % General intro function for CPP SPM
    %
    % USAGE::
    %
    %   cpp_ptb
    %   cpp_ptb('init')
    %   cpp_ptb('uninit')
    %   cpp_ptb('dev')
    %
    % :param action:
    % :type action: string
    %
    % :returns: - :action: (type) (dimension)
    %
    % Example::
    %
    % (C) Copyright 2022 CPP_PTB developers

    p = inputParser;

    defaultAction = 'init';

    addOptional(p, 'action', defaultAction, @ischar);

    parse(p, varargin{:});

    action = p.Results.action;

    switch lower(action)

        case 'init'

            initCppPtb();

        case 'uninit'

            uninitCppPtb();

        case 'run_tests'

            runTests();

    end

end

function initCppPtb()
    %
    % Adds the relevant folders to the path for a given session.
    % Has to be run to be able to use CPP_PTB.
    %
    % USAGE::
    %
    %   initCppPtb()
    %
    % (C) Copyright 2021 CPP_PTB developers

    thisDirectory = fileparts(mfilename('fullpath'));

    global CPP_PTB_INITIALIZED
    global CPP_PTB_PATHS

    if isempty(CPP_PTB_INITIALIZED)

        pathSep = ':';
        if ~isunix
            pathSep = ';';
        end

        CPP_PTB_PATHS = fullfile(thisDirectory);
        CPP_PTB_PATHS = cat(2, CPP_PTB_PATHS, ...
                            pathSep, ...
                            genpath(fullfile(thisDirectory, 'src')));
        CPP_PTB_PATHS = cat(2, CPP_PTB_PATHS, pathSep, ...
                            genpath(fullfile(thisDirectory, 'lib')));

        addpath(CPP_PTB_PATHS, '-begin');

        checkPtbVersion();

        CPP_PTB_INITIALIZED = true();

        detectCppPtb();

    else
        fprintf('\n\nCPP_PTB already initialized\n\n');

    end

end

function detectCppPtb()

    workflowsDir = cellstr(which('initPTB.m', '-ALL'));

    if isempty(workflowsDir)
        error('CPP_PTB is not in your MATLAB / Octave path.\n');

    elseif numel(workflowsDir) > 1
        fprintf('CPP_PTB seems to appear in several different folders:\n');
        for i = 1:numel(workflowsDir)
            fprintf('  * %s\n', fullfile(workflowsDir{i}, '..', '..'));
        end
        error('Remove all but one with ''pathtool'' .\n'); % or ''spm_rmpath

    end
end

function uninitCppPtb()
    %
    % Removes the added folders from the path for a given session.
    %
    % USAGE::
    %
    %   uninitCppPtb()
    %
    % (C) Copyright 2021 CPP_PTB developers

    thisDirectory = fileparts(mfilename('fullpath'));

    global CPP_PTB_INITIALIZED
    global CPP_PTB_PATHS

    if isempty(CPP_PTB_INITIALIZED) || ~CPP_PTB_INITIALIZED
        fprintf('\n\nCPP_PTB not initialized\n\n');
        return

    else
        rmpath(CPP_PTB_PATHS);

        if IsOctave
            clear -g CPP_PTB_PATHS CPP_PTB_INITIALIZED;
        else
            clearvars -GLOBAL CPP_PTB_PATHS CPP_PTB_INITIALIZED;
        end

    end

end

function runTests()
    %
    % (C) Copyright 2019 CPP_PTB developers

    tic;

    cpp_ptb();

    cd(fileparts(mfilename('fullpath')));

    fprintf(sprintf('\nHome is %s\n', getenv('HOME')));

    warning('OFF');

    folderToCover = fullfile(pwd, 'src');
    testFolder = fullfile(pwd, 'tests');

    success = moxunit_runtests(testFolder, ...
                               '-verbose', '-recursive', '-with_coverage', ...
                               '-cover', folderToCover, ...
                               '-cover_xml_file', 'coverage.xml', ...
                               '-cover_html_dir', fullfile(pwd, 'coverage_html'));

    if success
        system('echo 0 > test_report.log');
    else
        system('echo 1 > test_report.log');
    end

    toc;

end
