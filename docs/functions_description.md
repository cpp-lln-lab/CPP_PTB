<!-- vscode-markdown-toc -->
* 1. [function details](#functiondetails)
	* 1.1. [initPTB](#initPTB)
	* 1.2. [testKeyboards](#testKeyboards)
	* 1.3. [cleanUp](#cleanUp)
	* 1.4. [getExperimentStart](#getExperimentStart)
	* 1.5. [getExperimentEnd](#getExperimentEnd)
	* 1.6. [getResponse](#getResponse)
	* 1.7. [deg2Pix](#deg2Pix)
	* 1.8. [drawFixationCross](#drawFixationCross)
	* 1.9. [eyeTracker](#eyeTracker)
	* 1.10. [pressSpace4me](#pressSpace4me)
	* 1.11. [standByScreen](#standByScreen)
	* 1.12. [waitForTrigger](#waitForTrigger)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc --># functions description



##  1. <a name='functiondetails'></a>function details


###  1.1. <a name='initPTB'></a>initPTB

This will initialize PsychToolBox

-   screen
-   the windon opened takes the whole screen by default
-   set in debug mode with window transparency if necessary
-   can skip synch test if you ask for it (nicely)
-   gets the flip interval
-   computes the pixel per degree of visual angle
-   set font details
-   keyboard
-   sound

###  1.2. <a name='testKeyboards'></a>testKeyboards

Checks that the keyboards asked for properly connected.

If no key is pressed on the correct keyboard after the timeOut time this exits with an error.

###  1.3. <a name='cleanUp'></a>cleanUp

A wrapper function to close all windows, ports, show mouse cursor, close keyboard queues
and give access back to the keyboards.

###  1.4. <a name='getExperimentStart'></a>getExperimentStart

Wrapper function that will show a fixation cross and collect a start timestamp in `cfg.experimentStart`

###  1.5. <a name='getExperimentEnd'></a>getExperimentEnd

Wrapper function that will show a fixation cross and display in the console the whole experiment's duration in minutes and seconds  

###  1.6. <a name='getResponse'></a>getResponse

It is wrapper function to use `KbQueue` which is definitely what you should use to collect responses.

You can easily collect responses while running some other code at the same time.

It will only take responses from one device which can simply be the "main keyboard"
(the default device that PTB will find) or another keyboard connected to the computer
or the response box that the participant is using.

You can use it in a way so that it only takes responses from certain keys and ignore others (like
the triggers from an MRI scanner).

If you want to know more on how to use it check its help section and the `CPP_getResponseDemo.m`.

In brief, there are several actions you can execute with this function.

-   init: initialize the buffer for key presses on a given device (you can also specify the keys of interest that should be listened to).
-   start: start listening to the key presses (carefully insert into your script - where do you want to start buffering the responses).
-   check: till that point, it will check the buffer for all key presses.
    -   It only reports presses on the keys of interest mentioned at initialization.
    -   It **can** also check for presses on the escape key and abort if the escape key is part of the keys of interest.
-   flush: Empties the buffer of key presses in case you want to discard any previous key presses.
-   stop: Stops buffering key presses. You can still restart by calling "start" again.
-   release: Closes the buffer for good.

###  1.7. <a name='deg2Pix'></a>deg2Pix

For a given field value in degrees of visual angle in the input `structure`,
this computes its value in pixel using the pixel per degree value of the `cfg` structure
and returns a structure with an additional field with Pix suffix holding that new value.

###  1.8. <a name='drawFixationCross'></a>drawFixationCross

Define the parameters of the fixation cross in `cfg` and `expParameters` and this does the rest.

###  1.9. <a name='eyeTracker'></a>eyeTracker

This will handle the Eye Tracker (EyeLink set up) and can be called to initialize the connection and start the calibration, start/stop eye(s) movement recordings and save the `*.edf` file (named with BIDS specification from cpp-lln-lab/CPP_BIDS).  

###  1.10. <a name='pressSpace4me'></a>pressSpace4me

Use that to stop your script and only restart when the space bar is pressed.

###  1.11. <a name='standByScreen'></a>standByScreen

It shows a basic one-page instruction stored in `cfg.task.instruction` and wait for `space` stroke.

###  1.12. <a name='waitForTrigger'></a>waitForTrigger

Counts a certain number of triggers coming from the mri/scanner before returning.
Requires number of triggers to wait for.