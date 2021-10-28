function errorRestrictedKeysGetReponse
    %
    % (C) Copyright 2020 CPP_PTB developers

    errorStruct.message = 'getResponse reported a key press on a restricted key';
    errorStruct.identifier = 'getResponse:restrictedKey';

    error(errorStruct);
end
