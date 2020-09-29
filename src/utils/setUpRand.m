% (C) Copyright 2010-2020 Sam Schwarzkopf
% (C) Copyright 2020 CPP_PTB developers

function setUpRand()
    % setUpRand()
    %
    % Resets the seed of the random number generator. Will "adapt" depending on the matlab/octave
    % version.
    % It is of great importance to do this before anything else!
    %
    % For an alternative from PTB see `ClockRandSeed`

    seed = sum(100 * clock);

    if isOctave

        rand('twister', seed);
        randn('twister', seed);

    else

        try
            % Use the reccomended method in modern Matlab
            RandStream.setGlobalStream(RandStream('mt19937ar', 'seed', seed));
            disp('Using modern randomizer...');
        catch

            try
                % Use the recommended method in Matlab R2012a.
                rng('shuffle');
                disp('Using less modern randomizer...');
            catch

                try
                    % Use worse methods for old versions of Matlab (e.g. 7.1.0.246 (R14) SP3).
                    rand('twister', seed);
                    randn('twister', seed);
                    disp('Using outdated randomizer...');
                catch
                    % For very old Matlab versions these are the only methods you can use.
                    % These are supposed to be flawed although you will probably not
                    % notice any effect of this for most situations.
                    rand('state', seed);
                    randn('state', seed);
                    disp('Using "flawed" randomizer...');
                end
            end
        end
        
    end
