function outputFiltered = readOutputFilter(cfg, filterHeader, filterContent)
    % outputFiltered = readOutputFilter(cfg, filterHeader, filterContent)
    %
    % It will display in the command window the content of the `output.tsv' filtered by one element
    % of a target column. At the moment it works only for string content and can retrieve the tsv
    % path form `cfg`.
    %
    % DEPENDENCIES:
    % - bids_matlab (from CPP_BIDS)
    %
    % INPUT:
    %
    %  - cfg: the main experiment structure
    %  - filterHeader: string, the column header where the ctarget content is stored (e.g., for
    %    'condition name' will be 'trial type')
    %  - filterContent: string, the content of the column you want to filter out. It can take just
    %    part of the content name (e.g., you want to display the triggers and you have
    %    'trigger_motion' and 'trigger_static', 'trigger' as input will do)
    %
    % OUTPUT:
    %
    %  - outputFiltered: dataset with only the specified content, to see it in the command window
    %  use display(outputFiltered)


    % Get the outputfile path
    tsvFile = fullfile(cfg.dir.outputSubject, ...
        cfg.fileName.modality, ...
        cfg.fileName.events);

    % Read the the tsv file and store each column in a field of `output` structure
    output = bids.util.tsvread(tsvFile);

    % Get the index of the target contentent to filter and display
    filterIdx = find(strncmp(output.(filterHeader), filterContent, length(filterContent)));

    % Convert the structure to dataset
    outputDataset = struct2dataset(output);

    % Get the dataset with the content of intereset
    outputFiltered = outputDataset(filterIdx, :);

end
