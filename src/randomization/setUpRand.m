function [] = setUpRand()
    % Set up the randomizers for uniform and normal distributions.
    % It is of great importance to do this before anything else!

    seed = sum(100 * clock);

    if isOctave

        rand('state', seed);
        randn('state', seed);

    else

        RandStream.setGlobalStream(RandStream('mt19937ar', 'seed', seed));

    end

end
