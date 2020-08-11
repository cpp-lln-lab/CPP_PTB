% Eyelink already initialized!
% Running experiment on a 'EYELINK CL 4.56  ' tracker.
% Error in function Open:   Usage error
% Could not find *any* audio hardware on your system - or at least not with the provided deviceid, if any!
% Error in function FillRect:   Invalid Window (or Texture) Index provided: It doesn't correspond to an open window or texture.
% Did you close it accidentally via Screen('Close') or Screen('CloseAll') ?
% EYELINK: WARNING! PsychEyelinkCallRuntime() Failed to call eyelink runtime callback function PsychEyelinkDispatchCallback [rc = 1]!
% EYELINK: WARNING! Make sure that function is on your Matlab/Octave path and properly initialized.
% EYELINK: WARNING! May also be an error during execution of that function. Type ple at command prompt for error messages.
% EYELINK: WARNING! Auto-Disabling all callbacks to the runtime environment for safety reasons.
% Eyelink: In PsychEyelink_get_input_key(): Error condition detected: Trying to send TERMINATE_KEY abort keycode!

% Eyelink: In PsychEyelink_get_input_key(): Error condition detected: Trying to send TERMINATE_KEY abort keycode!
% Error in function FillRect:   Invalid Window (or Texture) Index provided: It doesn't correspond to an open window or texture.
% Did you close it accidentally via Screen('Close') or Screen('CloseAll') ?
% Error using Screen
% Usage:
%
% Screen('FillRect', windowPtr [,color] [,rect] )
%
% Error in eyeTracker (line 150)
%                 Screen('FillRect', cfg.screen.win, [0 0 0]);
%
% Error in visualLocTanslational (line 52)
%     [el] = eyeTracker('Calibration', cfg);

function [el, edfFile] = eyeTracker(input, cfg, varargin)
    % [el, edfFile] = eyeTracker(input, cfg, varargin)
    %
    %

    if ~cfg.eyeTracker.do

        el = [];

    else

        switch input

            case 'Calibration'

                %% STEP 2
                % Provide Eyelink with details about the graphics environment
                %  and perform some initializations. The information is returned
                %  in a structure that also contains useful defaults
                %  and control codes (e.g. tracker state bit and Eyelink key values).
                el = EyelinkInitDefaults(cfg.screen.win);

                % calibration has silver background with black targets, sound and smaller
                %  targets
                el.backgroundcolour        = [192 192 192, (cfg.screen.win)];
                el.msgfontcolour           = BlackIndex(cfg.screen.win);
                el.calibrationtargetcolour = BlackIndex(cfg.screen.win);
                el.calibrationtargetsize   = 1;
                el.calibrationtargetwidth  = 0.5;
                el.displayCalResults       = 1;

                % call this function for changes to the calibration structure to take
                %  affect
                EyelinkUpdateDefaults(el);

                %% STEP 3
                % Initialization of the connection with the Eyelink Gazetracker.
                %  exit program if this fails.

                % make sure EL is initialized.
                ELinit  = Eyelink('Initialize');
                if ELinit ~= 0
                    fprintf('Eyelink is not initialized, aborted.\n');
                    Eyelink('Shutdown');
                    Screen('CloseAll');
                    return
                end

                % make sure we're still connected.
                ELconnection = Eyelink('IsConnected');
                if ELconnection ~= 1
                    fprintf('Eyelink is not connected, aborted.\n');
                    Eyelink('Shutdown');
                    Screen('CloseAll');
                    return
                end

                %
                if ~EyelinkInit(0, 1)
                    fprintf('Eyelink Init aborted.\n');
                    return
                end

                % Open the edf file to write the data
                edfFile = 'demo.edf';
                Eyelink('Openfile', edfFile);

                [el.v, el.vs] = Eyelink('GetTrackerVersion');
                fprintf('Running experiment on a ''%s'' tracker.\n', el.vs);

                % make sure that we get gaze data from the Eyelink
                Eyelink('Command', 'link_sample_data = LEFT,RIGHT,GAZE,AREA');

                % STEP 4
                % SET UP TRACKER CONFIGURATION
                % Setting the proper recording resolution, proper calibration type,
                %   as well as the data file content;
                %            Eyelink('command', 'add_file_preamble_text ''Recorded by
                % EyelinkToolbox demo-experiment''');

                % This command is crucial to map the gaze positions from the tracker to
                %  screen pixel positions to determine fixation
                Eyelink('command', 'screen_pixel_coords = %ld %ld %ld %ld', 0, 0, 0, 0);
                Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, 0, 0);

                % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
                % DEFAULT CALIBRATION
                % set calibration type.
                Eyelink('command', 'calibration_type = HV5');

                % you must send this command with value NO for custom calibration
                %   you must also reset it to YES for subsequent experiments
                Eyelink('command', 'generate_default_targets = YES');

                % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

                %         % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
                %         % CUSTOM CALIBRATION
                %         % (SET MANUALLY THE DOTS COORDINATES, HERE FOR 6 DOTS)
                %         Eyelink('command', 'calibration_type = HV5');
                %         % you must send this command with value NO for custom calibration
                %         % you must also reset it to YES for subsequent experiments
                %         Eyelink('command', 'generate_default_targets = NO');
                %
                %         % calibration and validation target locations
                %         [width, height]=Screen('WindowSize', screenNumber);
                %         Eyelink('command','calibration_samples = 6');
                %         Eyelink('command','calibration_sequence = 0,1,2,3,4,5');
                %         Eyelink('command','calibration_targets = ...
                %             %d,%d %d,%d %d,%d %d,%d %d,%d',...
                %             640,512, ... %width/2,height/2
                %             640,102, ... %width/2,height*0.1
                %             640,614, ... %width/2,height*0.6
                %             128,341, ... %width*0.1,height*1/3
                %             1152,341 );  %width-width*0.1,height*1/3
                %
                %         Eyelink('command','validation_samples = 5');
                %         Eyelink('command','validation_sequence = 0,1,2,3,4,5');
                %         Eyelink('command','validation_targets = ...
                %             %d,%d %d,%d %d,%d %d,%d %d,%d',...
                %             640,512, ... %width/2,height/2
                %             640,102, ... %width/2,height*0.1
                %             640,614, ... %width/2,height*0.6
                %             128,341, ... %width*0.1,height*1/3
                %             1152,341 );  %width-width*0.1,height*1/3
                %         % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

                %             % set parser (conservative saccade thresholds)
                %             Eyelink('command', 'saccade_velocity_threshold = 35');
                %             Eyelink('command', 'saccade_acceleration_threshold = 9500');

                % set EDF file contents (not clear what this lines are used for)
                el.vsn = regexp(el.vs, '\d', 'match'); % wont work on EL

                % enter Eyetracker camera setup mode, calibration and validation
                EyelinkDoTrackerSetup(el);

                %         % do a final check of calibration using driftcorrection
                %         % You have to hit esc before return.
                %         EyelinkDoDriftCorrection(el);

                %         % do a final check of calibration using driftcorrection
                %         success=EyelinkDoDriftCorrection(el);
                %         if success~=1
                %             Eyelink('shutdown');
                %             cleanUp()
                %             return;
                %         end

                % Go back to black screen
                Screen('FillRect', cfg.screen.win, [0 0 0]);
                Screen('Flip', cfg.screen.win);

            case 'StartRecording'

                % STEP 5
                % EyeLink Start recording the block
                Eyelink('Command', 'set_idle_mode');
                WaitSecs(0.05);
                Eyelink('StartRecording');
                %         % here to tag the recording, in the past caused delays during the
                %         %  presentation so I avoided to use it
                %         Eyelink('message',['TRIALID ',num2str(blocks),'_startTrial']);

                % check recording status, stop display if error
                checkrec = Eyelink('checkrecording');
                if checkrec ~= 0
                    fprintf('\nEyelink is not recording.\n\n');
                    Eyelink('Shutdown');
                    Screen('CloseAll');
                    return
                end

                % record a few samples before we actually start displaying
                %  otherwise you may lose a few msec of data
                WaitSecs(0.1);

                % HERE START THE STIMULATION OF THE BLOCK
                % to mark the beginning of the trial
                Eyelink('Message', 'SYNCTIME');

            case 'StopRecordings'

                % STEP 8
                % finish up: stop recording eye-movements,
                % EyeLink Stop recording the block
                Eyelink('Message', 'BLANK_SCREEN');
                % adds 100 msec of data to catch final events
                WaitSecs(0.1);
                % close graphics window, close data file and shut down tracker
                Eyelink('StopRecording');

            case 'Shutdown'

                edfFileName = fullfile( ...
                    cfg.dir.outputSubject, ...
                    'eyetracker', ...
                    cfg.fileName.eyetracker);

                edfFile = 'demo.edf';

                % STEP 6
                % At the end of the experiment, save the edf file and shut down connection
                %  with Eyelink

                Eyelink('Command', 'set_idle_mode');
                WaitSecs(0.5);
                Eyelink('CloseFile');

                % download data file
                try
                    fprintf('Receiving data file ''%s''\n', edfFileName);

                    status = Eyelink('ReceiveFile', '', edfFileName);

                    if status > 0
                        fprintf('ReceiveFile status %d\n', status);
                    end

                    if 2 == exist(edfFileName, 'file')

                        fprintf('Data file ''%s'' can be found in ''%s''\n', ...
                            cfg.fileName.eyetracker, ...
                            fullfile(cfg.dir.outputSubject, 'eyetracker'));

                    end

                catch

                    fprintf('Problem receiving data file ''%s''\n', edfFileName);

                end

                Eyelink('shutdown');

        end

    end

end

%% subfunctions for iView

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
