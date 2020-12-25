% (C) Copyright 2020 CPP_PTB developers

function shuffled = shuffle(unshuffled)
    %
    % Is just there to replace the ``Shuffle`` function from PTB in case it is not in the
    % path. Can be useful for testing or for continuous integration.
    %
    %
    % USAGE::
    %
    %   shuffled = shuffle(unshuffled)
    %

    try
        shuffled = Shuffle(unshuffled);
    catch
        shuffled = unshuffled(randperm(length(unshuffled)));
    end
end
