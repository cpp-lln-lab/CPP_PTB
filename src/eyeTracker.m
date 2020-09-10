function [el, cfg] = eyeTracker(input, cfg)
    % [el] = eyeTracker(input, cfg)
    %
    % Wrapper function that deals with all the necessery actions to implement
    %  Eye Tracker recording with eyelink.
    %
    % INPUT
    %
    % - action: Defines what we want the function to do
    %  - Calibration: to initialize EyeLink and run calibration
    %    -- 'default calibration' (default) will run a calibration with 6 points
    %    -- 'custom calibration'  (cfg.eyeTracker.defaultCalibration = 'false') will run a
    %        calibration with 6 points but the experimenter can choose their position on the screen
    %  - StartRecording: to start eye movements recording
    %  - StopRecordings: to stop eye movements recornding
    %  - Shutdown: to save the `.edf` file with BIDS compliant name, from cpp-lln-lab/CPP_BIDS, in
    %    the output folder and shut the connection between the stimulation computer and the EyeLink
    %    computer
    %
    %  OUTPUT
    %
    % `el` is a structure where are stored EyeLink setup variables

    if ~cfg.eyeTracker.do

        el = [];

    else

        switch input

            case 'Calibration'

                %% Initialization
                % Provide Eyelink with details about the graphics environment and perform some
                %  initializations. The information is returned in a structure that also contains
                %  useful defaults and control codes (e.g. tracker state bit and Eyelink key
                %  values).

                % Provide Screen id where present the calibration
                el = EyelinkInitDefaults(cfg.screen.win);

                % Calibration has silver background with black targets, sound and smaller
                %  targets
                el.backgroundcolour = [cfg.eyeTracker.backgroundColor, (cfg.screen.win)];
                el.msgfontcolour = cfg.eyeTracker.fontColor;
                el.calibrationtargetcolour = cfg.eyeTracker.calibrationTargetColor;
                el.calibrationtargetsize = cfg.eyeTracker.calibrationTargetSize;
                el.calibrationtargetwidth = cfg.eyeTracker.calibrationTargetWidth;
                el.displayCalResults = cfg.eyeTracker.displayCalResults;

                % Call this function for changes to the calibration structure to take
                %  affect.
                EyelinkUpdateDefaults(el);

                % Initialize EL and make sure it worked: returns 0 if OK, -1 if error.

                % Check that EL is initialzed and connected, otherwise abort experiment
                eyetrackerCheckConnection;

                % Open the edf file to write the data.
                edfFile = 'demo.edf';
                Eyelink('Openfile', edfFile);

                % Get EyeLink setup information.
                [el.v, el.vs] = Eyelink('GetTrackerVersion');
                fprintf('Running experiment on a ''%s'' tracker.\n', el.vs);

                % Save EL setup version in cfg
                cfg.eyeTracker.eyeLinkVersionString = el.vs;

                % Make sure that we get gaze data from the Eyelink.
                Eyelink('Command', 'link_sample_data = LEFT,RIGHT,GAZE,AREA');
                Eyelink('Command', 'link_event_data = GAZE,GAZERES,HREF,AREA,VELOCITY');
                Eyelink('Command', 'link_event_filter = LEFT,RIGHT,FIXATION,BLINK,SACCADE,BUTTON');

                %% Calibration

                % This command is crucial to map the gaze positions from the tracker to
                %  screen pixel positions to determine fixation.
                Eyelink('Command', 'screen_pixel_coords = %ld %ld %ld %ld', 0, 0, 0, 0);
                Eyelink('Message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, 0, 0);

                % Set calibration type.
                Eyelink('Command', 'calibration_type = HV5');

                if cfg.eyeTracker.defaultCalibration

                    % Set default calibration parameters.
                    Eyelink('Command', 'generate_default_targets = YES');

                else

                    % Set custom calibration parameters.
                    Eyelink('Command', 'generate_default_targets = NO');

                    % Calibration target locations, set manually the dots
                    %  coordinates, here for 6 dots.

                    % [width, height]=Screen('WindowSize', screenNumber);

                    Eyelink('Command', 'calibration_samples = 6');
                    Eyelink('Command', 'calibration_sequence = 0,1,2,3,4,5');
                    Eyelink('Command', 'calibration_targets = %d,%d %d,%d %d,%d %d,%d %d,%d', ...
                        640, 512, ... % width/2,height/2
                        640, 102, ... % width/2,height*0.1
                        640, 614, ... % width/2,height*0.6
                        128, 341, ... % width*0.1,height*1/3
                        1152, 341);  % width-width*0.1,height*1/3

                    % Validation target locations
                    Eyelink('Command', 'validation_samples = 5');
                    Eyelink('Command', 'validation_sequence = 0,1,2,3,4,5');
                    Eyelink('Command', 'validation_targets = %d,%d %d,%d %d,%d %d,%d %d,%d', ...
                        640, 512, ... % width/2,height/2
                        640, 102, ... % width/2,height*0.1
                        640, 614, ... % width/2,height*0.6
                        128, 341, ... % width*0.1,height*1/3
                        1152, 341);  % width-width*0.1,height*1/3

                end

                % Set EDF file contents (not clear what this lines are used for).
                el.vsn = regexp(el.vs, '\d', 'match'); % won't work on EL

                fprintf('Waiting for calibration \n');

                % Enter Eyetracker camera setup mode, calibration and validation.
                EyelinkDoTrackerSetup(el);

                % Go back to default screen background color.
                Screen('FillRect', cfg.screen.win, cfg.color.background);
                Screen('Flip', cfg.screen.win);

            case 'StartRecording'

                %% Start recording of eye-movements

                % EyeLink Start recording the block.
                Eyelink('Command', 'set_idle_mode');
                WaitSecs(0.05);
                Eyelink('StartRecording');

                % Check recording status, stop display if error.
                checkrec = Eyelink('checkrecording');
                if checkrec ~= 0
                    warning('\nEyelink is not recording.\n\n');
                    Eyelink('Shutdown');
                    Screen('CloseAll');
                    return
                end

                % Record a few samples before we actually start displaying otherwise you may lose
                %  a few msec of data.
                WaitSecs(0.1);

                % Mark the beginning of the trial, here start the stimulation of the experiment.
                Eyelink('Message', 'start_recording');

            case 'StopRecordings'

                %% Stop recording of eye-movements

                % EyeLink Stop recording the block.
                Eyelink('Message', 'stop_recording');

                % Add 100 msec of data to catch final events.
                WaitSecs(0.1);

                % Stop recoding.
                Eyelink('StopRecording');

            case 'Shutdown'

                %% End of the experiment
                % Save the edf file and shut down connection with Eyelink.

                % Set the edf file path + name.
                edfFileName = fullfile( ...
                    cfg.dir.outputSubject, ...
                    cfg.fileName.modality, ...
                    cfg.fileName.eyetracker);

                Eyelink('Command', 'set_idle_mode');

                WaitSecs(0.5);

                % Close the file to be ready to be exported and saved.
                Eyelink('CloseFile');

                % Download data file
                try
                    fprintf('Receiving data file ''%s''\n', edfFileName);

                    % Download the file and check the status: returns file size if OK, 0 if file
                    %  transfer was cancelled, negative = error.
                    elReceiveFile = Eyelink('ReceiveFile', '', edfFileName);

                    if elReceiveFile > 0
                        fprintf('Exporting eye tracker file of size %d\n', elReceiveFile);
                    end

                    if exist(edfFileName, 'file') == 2

                        fprintf('Data file ''%s'' can be found in ''%s''\n', ...
                            cfg.fileName.eyetracker, ...
                            fullfile(cfg.dir.outputSubject, 'eyetracker'));

                    end

                catch

                    fprintf('Problem receiving eye tracker data ''%s''\n', edfFileName);

                end

                % Close connection with EyeLink.
                Eyelink('shutdown');

        end

    end

end

function eyetrackerCheckConnection

    % Initialize EL and make sure it worked: returns 0 if OK, -1 if error.
    %  Exit program if this fails.
    elInit  = Eyelink('Initialize');
    if elInit ~= 0
        Eyelink('shutdown');
        error([newline 'Eyelink is not initialized, aborted.']);
    end

    % Make sure EL is still connected: returns 1 if connected, -1 if dummy-connected,
    %  2 if broadcast-connected and 0 if not connected. Exit program if this fails.
    elConnection = Eyelink('IsConnected');
    if elConnection ~= 1
        Eyelink('shutdown');
        error([newline 'Eyelink is not connected, aborted.']);
    end

    % Initialize Eyelink system and connection: returns 1 when succesful, 0
    % otherwise
    if ~EyelinkInit(0, 1)
        Eyelink('shutdown');
        fprintf('Eyelink Init aborted.\n');
        return
    end

end

%% subfunctions for iView in case some uses that type of eyetracker and wants to implement them

% function ivx = eyeTrackInit(cfg)
%     % initialize iView eye tracker
%
%     ivx = [];
%
%     if cfg.eyeTracker
%
%         host = cfg.eyetracker.Host;
%         port = cfg.eyetracker.Port;
%         window = cfg.eyetracker.Window;
%
%         % original: ivx=iviewxinitdefaults(window, 9 , host, port);
%         ivx = iviewxinitdefaults2(window, 9, [], host, port);
%         ivx.backgroundColour = 0;
%         [~, ivx] = iViewX('openconnection', ivx);
%         [success, ivx] = iViewX('checkconnection', ivx);
%         if success ~= 1
%             error('connection to eye tracker failed');
%         end
%     end
% end
%
% function eyeTrackStart(ivx, cfg)
%     % start iView eye tracker
%     if cfg.eyeTracker
%         % to clear data buffer
%         iViewX('clearbuffer', ivx);
%         % start recording
%         iViewX('startrecording', ivx);
%         iViewX('message', ivx, ...
%             [ ...
%             'Start_Ret_', ...
%             'Subj_', cfg.Subj, '_', ...
%             'Run', num2str(cfg.Session(end)),  '_', ...
%             cfg.Apperture, '_', ...
%             cfg.Direction]);
%         iViewX('incrementsetnumber', ivx, 0);
%     end
% end
%
% function eyeTrackStop(ivx, cfg)
%     % stop iView eye tracker
%
%     if cfg.eyeTracker
%
%         % stop tracker
%         iViewX('stoprecording', ivx);
%
%         % save data file
%         thedatestr = datestr(now, 'yyyy-mm-dd_HH.MM');
%         strFile = fullfile(OutputDir, ...
%             [cfg.Subj, ...
%             '_run', num2str(cfg.Session(end)), '_', ...
%             cfg.Apperture, '_', ...
%             cfg.Direction, '_', ...
%             thedatestr, '.idf"']);
%         iViewX('datafile', ivx, strFile);
%
%         % close iView connection
%         iViewX('closeconnection', ivx);
%     end
% end
