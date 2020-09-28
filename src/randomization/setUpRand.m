function [] = setUpRand()
    % Set up the randomizers for uniform and normal distributions.
    % It is of great importance to do this before anything else!

    % For an alternative from PTB see `ClockRandSeed`

    seed = sum(100 * clock);

    if isOctave

        rand('twister', seed);
        randn('twister', seed);

    else

        RandStream.setGlobalStream(RandStream('mt19937ar', 'seed', seed));

    end

end
