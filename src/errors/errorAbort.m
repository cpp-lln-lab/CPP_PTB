function errorAbort
    %
    % (C) Copyright 2020 CPP_PTB developers

    errorStruct.message = 'Escape key press detected: aborting experiment.';
    errorStruct.identifier = 'checkAbort:abortRequested';

    error(errorStruct);
end
