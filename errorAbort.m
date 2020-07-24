function errorAbort
    errorStruct.message = 'Escape key press detected: aborting experiment.';
    errorStruct.identifier = 'checkAbort:abortRequested';

    error(errorStruct);
end
