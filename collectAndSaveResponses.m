function responseEvents = collectAndSaveResponses(cfg, logFile, experimentStart)

    responseEvents = getResponse('check', cfg.keyboard.responseBox, cfg);

    if isfield(responseEvents(1), 'onset') && ~isempty(responseEvents(1).onset)

        for iResp = 1:size(responseEvents, 1)
            responseEvents(iResp).onset = ...
                responseEvents(iResp).onset - experimentStart;
        end

        responseEvents.fileID = logFile.fileID;
        responseEvents.extraColumns = logFile.extraColumns;
        saveEventsFile('save', cfg, responseEvents);

    end
end
