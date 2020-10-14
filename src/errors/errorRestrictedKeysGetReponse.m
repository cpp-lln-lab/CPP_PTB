% (C) Copyright 2020 CPP_PTB developers

function errorRestrictedKeysGetReponse

    errorStruct.message = 'getResponse reported a key press on a restricted key';
    errorStruct.identifier = 'getResponse:restrictedKey';

    error(errorStruct);
end
