% (C) Copyright 2020 CPP_PTB developers

function [outputFiltered] = readAndFilterLogfile(columnName, filterBy, varargin)
    %
    % It will display in the command window the content of the `output.tsv` filtered
    % by one element of a target column. Dependecies: bids_matlab (from CPP_BIDS)
    %
    % USAGE:
    %
    %   [outputFiltered] = readOutputFilter(filterHeader, filterContent, varargin)
    %
    % :param columnName: the header of the column where the content of insterest is stored
    %                    (e.g., for 'trigger' will be 'trial type')
    % :type columnName: string
    % :param filterBy: the content of the column you want to filter out. It can take just
    %                  part of the content name (for example, you want to display the triggers and
    %                  you have ``trigger_motion`` and ``trigger_static``, ``trigger`` as input
    %                  will do)
    % :type filterBy: string
    % :param varargin: either ``cfg`` (to display the last run output) or the file path as string
    %
    % :returns: 
    %
    % - :outputFiltered: dataset with only the specified content to see it in the 
    %                    command window use display(outputFiltered)
    %
    %

    % Checke if input is cfg or the file path
    if ischar(varargin{1})
        tsvFile = varargin{1};
    elseif isstruct(varargin{1})
        tsvFile = fullfile(varargin{1}.dir.outputSubject, ...
                           varargin{1}.fileName.modality, ...
                           varargin{1}.fileName.events);
    end

    % Check if the file exists
    if ~exist(tsvFile, 'file')
        error([newline 'Input file does not exist']);
    end

    % Read the the tsv file and store each column in a field of `output` structure
    output = bids.util.tsvread(tsvFile);

    % Get the index of the target contentent to filter and display
    filterIdx = find(strncmp(output.(columnName), filterBy, length(filterBy)));

    % Convert the structure to dataset
    outputDataset = struct2dataset(output);

    % Get the dataset with the content of intereset
    outputFiltered = outputDataset(filterIdx, :);

end
