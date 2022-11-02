function checkAbortGetResponse(responseEvents, cfg)
    %

    % (C) Copyright 2020 CPP_PTB developers
    if isfield(responseEvents, 'keyName') > 0 && ...
            any( ...
                strcmpi({responseEvents(:).keyName}, cfg.keyboard.escapeKey) ...
               )
        errorAbortGetReponse;
    end
end
