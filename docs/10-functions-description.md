# functions description

<!-- TOC -->

-   [functions description](#functions-description)
    -   [General functions](#general-functions)
        -   [initPTB](#initptb)
        -   [cleanUp](#cleanup)
        -   [getExperimentStart](#getexperimentstart)
        -   [getExperimentEnd](#getexperimentend)
        -   [degToPix](#degtopix)
        -   [computeFOV](#computefov)
        -   [eyeTracker](#eyetracker)
        -   [standByScreen](#standbyscreen)
        -   [waitForTrigger](#waitfortrigger)
        -   [waitFor](#waitfor)
        -   [readAndFilterLogfile](#readandfilterlogfile)
    -   [Keyboard functions: response collection and aborting experiment](#keyboard-functions-response-collection-and-aborting-experiment)
        -   [testKeyboards](#testkeyboards)
        -   [getResponse](#getresponse)
        -   [pressSpaceForme](#pressspaceforme)
        -   [checkAbort](#checkabort)
    -   [Fixations](#fixations)
        -   [drawFixationCross](#drawfixationcross)
    -   [Drawing dots](#drawing-dots)
    -   [Drawing apertures](#drawing-apertures)
    -   [Randomization](#randomization)
        -   [shuffle](#shuffle)
        -   [setTargetPositionInSequence](#settargetpositioninsequence)
        -   [repeatShuffleConditions](#repeatshuffleconditions)

<!-- /TOC -->

## General functions

### initPTB

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

### cleanUp

A wrapper function to close all windows, ports, show mouse cursor, close
keyboard queues and give you back access to the keyboards.

### getExperimentStart

Wrapper function that will show a fixation cross and collect a start timestamp
in `cfg.experimentStart`

### getExperimentEnd

Wrapper function that will show a fixation cross and display in the console the
whole experiment's duration in minutes and seconds

### degToPix

For a given field value in degrees of visual angle in the input `structure`,
this computes its value in pixel using the pixel per degree value of the `cfg`
structure and returns a structure with an additional field with Pix suffix
holding that new value.

### computeFOV

Gives you the width of the field on view in degress of visual angle based on the
screen width and distance to the screen in cm (taken from the `cfg`)

### eyeTracker

This will handle the Eye Tracker (EyeLink set up) and can be called to
initialize the connection and start the calibration, start/stop eye(s) movement
recordings and save the `*.edf` file (named with BIDS specification from
cpp-lln-lab/CPP_BIDS).

There are several actions to perform:

-   Calibration: to initialize EyeLink and run calibration
    -   'default calibration' (default) will run a calibration with 6 points
    -   'custom calibration' (cfg.eyeTracker.defaultCalibration = 'false') will
        run a calibration with 6 points but the experimenter can choose their
        position on the screen
-   StartRecording: to start eye movements recording
-   Message: will add a tag (e.g. 'Block_n1') in the ET output file, the tag is
    a string and it is input from `varargin`
-   StopRecordings: to stop eye movements recornding
-   Shutdown: to save the `.edf` file with BIDS compliant name, from
    cpp-lln-lab/CPP_BIDS, in the output folder and shut the connection between
    the stimulation computer and the EyeLink computer

### standByScreen

It shows a basic one-page instruction stored in `cfg.task.instruction` and wait
for `space` stroke.

### waitForTrigger

Counts a certain number of triggers coming from the mri/scanner before
returning. Requires number of triggers to wait for.

This can also be used if you want to let the scanner pace the experiment and you
want to synch stimulus presentation to the scanner trigger.

### waitFor

A generic function that you can use to for a certain amount of time or a number
of triggers

### readAndFilterLogfile

Displays in the command window part of the `*events.tsv` file filtered by an
element (e.g. 'trigger'). It can take the last output produced (through `cfg`)
or any output BIDS compatible (through file path).

## Keyboard functions: response collection and aborting experiment

### testKeyboards

Checks that the keyboards asked for are properly connected.

If no key is pressed on the correct keyboard after the timeOut time this exits
with an error.

### getResponse

It is wrapper function to use `KbQueue` which is definitely what you should use
to collect responses.

You can easily collect responses while running some other code at the same time.

It will only take responses from one device which can simply be the "main
keyboard" (the default device that PTB will find) or another keyboard connected
to the computer or the response box that the participant is using.

You can use it in a way so that it only takes responses from certain keys and
ignore others (like the triggers from an MRI scanner).

If you want to know more on how to use it check its help section and the
`CPP_getResponseDemo.m`.

In brief, there are several actions you can execute with this function.

-   init: initialize the buffer for key presses on a given device (you can also
    specify the keys of interest that should be listened to).
-   start: start listening to the key presses (carefully insert into your
    script - where do you want to start buffering the responses).
-   check: till that point, it will check the buffer for all key presses. - It
    only reports presses on the keys of interest mentioned at initialization. -
    It **can** also check for presses on the escape key and abort if the escape
    key is part of the keys of interest.
-   flush: empties the buffer of key presses in case you want to discard any
    previous key presses.
-   stop: stops buffering key presses. You can still restart by calling "start"
    again.
-   release: closes the buffer for good.

### pressSpaceForme

Use that to stop your script and only restart when the space bar is pressed.

This can be useful if as an experimenter you want to have one final check on
some set up before giving the green light.

### checkAbort

A simple function that will quit your experiment if you press the key you have
defined in `cfg.keyboard.escapeKey`.

## Fixations

### drawFixationCross

Define the parameters of the fixation cross in `cfg` and `expParameters` and
this does the rest.

## Drawing dots

## Drawing apertures

## Randomization

Functions that can be used to create random stimuli sequences.

### shuffle

Is just there to replace the Shuffle function from PTB in case it is not in the
path. Can be useful for testing or for continuous integration.

### setTargetPositionInSequence

For a sequence of length `seqLength` where we want to insert `nbTarget` targets,
this will return `nbTarget` random position in that sequence and make sure that
they are not in consecutive positions.

### repeatShuffleConditions

Given `baseConditionVector`, a vector of conditions (coded as numbers), this
will create a longer vector made of `nbRepeats` of this base vector and make
sure that a given condition is not repeated one after the other.

### 6.4. setUpRand

Set up the randomizers for uniform and normal distributions. It is of great
importance to do this before anything else!
