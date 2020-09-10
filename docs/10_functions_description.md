# functions description

<!-- vscode-markdown-toc -->
* 1. [ General functions](#Generalfunctions)
	* 1.1. [initPTB](#initPTB)
	* 1.2. [cleanUp](#cleanUp)
	* 1.3. [getExperimentStart](#getExperimentStart)
	* 1.4. [getExperimentEnd](#getExperimentEnd)
	* 1.5. [degToPix](#degToPix)
	* 1.6. [computeFOV](#computeFOV)
	* 1.7. [eyeTracker](#eyeTracker)
	* 1.8. [standByScreen](#standByScreen)
	* 1.9. [waitForTrigger](#waitForTrigger)
	* 1.10. [waitFor](#waitFor)
	* 1.11. [readAndFilterLogfile](#readAndFilterLogfile)
* 2. [Keyboard functions: response collection and aborting experiment](#Keyboardfunctions:responsecollectionandabortingexperiment)
	* 2.1. [testKeyboards](#testKeyboards)
	* 2.2. [getResponse](#getResponse)
	* 2.3. [pressSpaceForme](#pressSpaceForme)
* 3. [Fixations](#Fixations)
	* 3.1. [drawFixationCross](#drawFixationCross)
* 4. [Drawing dots](#Drawingdots)
* 5. [Drawing apertures](#Drawingapertures)
* 6. [Randomization](#Randomization)
	* 6.1. [shuffle](#shuffle)
	* 6.2. [setTargetPositionInSequence](#setTargetPositionInSequence)
	* 6.3. [repeatShuffleConditions](#repeatShuffleConditions)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='Generalfunctions'></a> General functions

###  1.1. <a name='initPTB'></a>initPTB

This will initialize PsychToolBox.

It is pretty much necessary to use this function to set up the stage for using 
any other functions of CPP_PTB.

-   checks OS and PTB version
-   set some defaults
-   set the screen details
    -   the window opened takes the whole screen by default
    -   set in debug mode with window transparency if necessary
    -   can skip synch test if you ask for it (nicely)
    -   gets the flip interval
    -   computes the pixel per degree of visual angle
-   set fixation cross details
-   set font details
-   keyboard
-   hides cursor
-   sound

###  1.2. <a name='cleanUp'></a>cleanUp

A wrapper function to close all windows, ports, show mouse cursor, close keyboard 
queues and give you back access to the keyboards.

###  1.3. <a name='getExperimentStart'></a>getExperimentStart

Wrapper function that will show a fixation cross and collect a start timestamp 
in `cfg.experimentStart`

###  1.4. <a name='getExperimentEnd'></a>getExperimentEnd

Wrapper function that will show a fixation cross and display in the console 
the whole experiment's duration in minutes and seconds  

###  1.5. <a name='degToPix'></a>degToPix

For a given field value in degrees of visual angle in the input `structure`,
this computes its value in pixel using the pixel per degree value of the `cfg` 
structure and returns a structure with an additional field with Pix suffix holding that new value.

###  1.6. <a name='computeFOV'></a>computeFOV

Gives you the width of the field on view in degress of visual angle based on 
the screen width and distance to the screen in cm (taken from the `cfg`)

###  1.7. <a name='eyeTracker'></a>eyeTracker

This will handle the Eye Tracker (EyeLink set up) and can be called to initialize 
the connection and start the calibration, start/stop eye(s) movement recordings 
and save the `*.edf` file (named with BIDS specification from cpp-lln-lab/CPP_BIDS).  

There are several actions to perform:

- Calibration: to initialize EyeLink and run calibration
  - 'default calibration' (default) will run a calibration with 6 points
  - 'custom calibration'  (cfg.eyeTracker.defaultCalibration = 'false') will run 
a calibration with 6 points but the experimenter can choose their position on the screen
- StartRecording: to start eye movements recording
- StopRecordings: to stop eye movements recornding
- Shutdown: to save the `.edf` file with BIDS compliant name, from cpp-lln-lab/CPP_BIDS, 
in the output folder and shut the connection between the stimulation computer and the EyeLink computer

###  1.8. <a name='standByScreen'></a>standByScreen

It shows a basic one-page instruction stored in `cfg.task.instruction` and wait for `space` stroke.

###  1.9. <a name='waitForTrigger'></a>waitForTrigger

Counts a certain number of triggers coming from the mri/scanner before returning.
Requires number of triggers to wait for.

This can also be used if you want to let the scanner pace the experiment and you 
want to synch stimulus presentation to the scanner trigger.

###  1.10. <a name='waitFor'></a>waitFor

A generic function that you can use to for a certain amount of time or a number of triggers

###  1.11. <a name='readAndFilterLogfile'></a>readAndFilterLogfile

Displays in the command window part of the `*events.tsv` file filtered by an element 
(e.g. 'trigger'). It can take the last output produced (through `cfg`) or any 
output BIDS compatible (through file path).

##  2. <a name='Keyboardfunctions:responsecollectionandabortingexperiment'></a>Keyboard functions: response collection and aborting experiment

###  2.1. <a name='testKeyboards'></a>testKeyboards

Checks that the keyboards asked for are properly connected.

If no key is pressed on the correct keyboard after the timeOut time this exits with an error.

###  2.2. <a name='getResponse'></a>getResponse

It is wrapper function to use `KbQueue` which is definitely what you should use 
to collect responses.

You can easily collect responses while running some other code at the same time.

It will only take responses from one device which can simply be the "main keyboard"
(the default device that PTB will find) or another keyboard connected to the computer
or the response box that the participant is using.

You can use it in a way so that it only takes responses from certain keys and ignore others (like
the triggers from an MRI scanner).

If you want to know more on how to use it check its help section and the `CPP_getResponseDemo.m`.

In brief, there are several actions you can execute with this function.

-   init: initialize the buffer for key presses on a given device (you can also 
specify the keys of interest that should be listened to).
-   start: start listening to the key presses (carefully insert into your script - 
where do you want to start buffering the responses).
-   check: till that point, it will check the buffer for all key presses.
    -   It only reports presses on the keys of interest mentioned at initialization.
    -   It **can** also check for presses on the escape key and abort if the escape 
key is part of the keys of interest.
-   flush: empties the buffer of key presses in case you want to discard any 
previous key presses.
-   stop: stops buffering key presses. You can still restart by calling "start" again.
-   release: closes the buffer for good.

###  2.3. <a name='pressSpaceForme'></a>pressSpaceForme

Use that to stop your script and only restart when the space bar is pressed.

This can be useful if as an experimenter you want to have one final check on 
some set up before giving the green light.

### checkAbort

A simple function that will quit your experiment if you press the key you have 
defined in `cfg.keyboard.escapeKey`. 

##  3. <a name='Fixations'></a>Fixations

###  3.1. <a name='drawFixationCross'></a>drawFixationCross

Define the parameters of the fixation cross in `cfg` and `expParameters` and this does the rest.

##  4. <a name='Drawingdots'></a>Drawing dots

##  5. <a name='Drawingapertures'></a>Drawing apertures

##  6. <a name='Randomization'></a>Randomization

Functions that can be used to create random stimuli sequences.

###  6.1. <a name='shuffle'></a>shuffle

Is just there to replace the Shuffle function from PTB in case it is not in the 
path. Can be useful for testing or for continuous integration.

###  6.2. <a name='setTargetPositionInSequence'></a>setTargetPositionInSequence

For a sequence of length `seqLength` where we want to insert `nbTarget` targets, 
this will return `nbTarget` random position in that sequence and make sure that 
they are not in consecutive positions.

###  6.3. <a name='repeatShuffleConditions'></a>repeatShuffleConditions

Given `baseConditionVector`, a vector of conditions (coded as numbers), this will 
create a longer vector made of `nbRepeats` of this base vector and make sure that 
a given condition is not repeated one after the other.
