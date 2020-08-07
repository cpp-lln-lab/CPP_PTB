function responseEvents = collectAndSaveResponses(cfg, logFile, experimentStart)

    responseEvents = getResponse('check', cfg.keyboard.responseBox, cfg);

    if isfield(responseEvents(1), 'onset') && ~isempty(responseEvents(1).onset)

        for iResp = 1:size(responseEvents, 1)
            responseEvents(iResp).onset = ...
                responseEvents(iResp).onset - experimentStart;
        end

        responseEvents(1).fileID = logFile.fileID;
        responseEvents(1).extraColumns = logFile.extraColumns;
        saveEventsFile('save', cfg, responseEvents);

    end
end
