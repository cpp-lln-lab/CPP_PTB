% (C) Copyright 2020 CPP_PTB developers

function shuffled = shuffle(unshuffled)
    % in case PTB is not in the path
    % mostly for unit test
    %

    try
        shuffled = Shuffle(unshuffled);
    catch
        shuffled = unshuffled(randperm(length(unshuffled)));
    end
end
