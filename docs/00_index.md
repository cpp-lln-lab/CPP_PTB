# CPP_PTB documentation

<!-- vscode-markdown-toc -->
* 1. [the CFG structure](#theCFGstructure)
* 2. [Setting up keyboards](#Settingupkeyboards)
* 3. [functions descriptions](#functionsdescriptions)
* 4. [Annexes](#Annexes)
	* 4.1. [Experiment template [ WIP ]](#ExperimenttemplateWIP)
	* 4.2. [devSandbox (stand-alone)](#devSandboxstand-alone)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='theCFGstructure'></a>the CFG structure

The `cfg` structure is where most of the information about your experiment will be defined.

Below we try to outline what it contains.

Some of those fields you can set yourself while some others will be created and filled after running
`setDefaultsPTB.m` and `initPTB.m`.

- `setDefaultsPTB.m` sets some default values for things about your experiment that that do not "depend" on your system or that PTB cannot "know". For example the width of the screen in cm or the dimensions of the fixation cross you want to use... 
- `initPTB.m` will fill in the fields that ARE system dependent like the screen refresh rate, the reference of the window that PTB opened and where to flip stimulus to.

If no value is provided here, it means that there is no set default (or that the `initPTB` takes care of it).

```matlab
%% -------------------------------------------------------------------------- %%
							SET BY setDefaultsPTB
%% -------------------------------------------------------------------------- %%
cfg.testingDevice = 'pc'; % could be 'mri', 'eeg', 'meg'


%% -------------------------------------------------------------------------- %%
% cfg.keyboard
cfg.keyboard.keyboard = []; % device index for the main keyboard 
						(that of the experimenter)
cfg.keyboard.responseBox = []; % device index used by the participants 
cfg.keyboard.responseKey = {}; % list the keys that PTB should "listen" to when 
% using KbQueue to collect responses ; if empty PTB will listen to 
						all key presses
cfg.keyboard.escapeKey = 'ESCAPE'; % key to press to escape


%% -------------------------------------------------------------------------- %%
% cfg.debug
cfg.debug.do = true; % if true this will make less PTB tolerant with 
						bad synchronisation
cfg.debug.transpWin = true; % makes the stimulus windows semi-transparent: 
						useful when designing your experiment
cfg.debug.smallWin = true; % open a small window and not a full screen window ; 
                    	can be useful for debugging

%% -------------------------------------------------------------------------- %%
% cfg.text
cfg.text.font = 'Courier New';
cfg.text.size = 18;
cfg.text.style = 1; % bold


%% -------------------------------------------------------------------------- %%
% cfg.color
cfg.color.background = [0 0 0]; % [r g b] each in 0-255


%% -------------------------------------------------------------------------- %%
% cfg.screen
cfg.screen.monitorWidth = 42;% in cm
cfg.screen.monitorDistance = 134;% in cm
cfg.screen.resolution = {[], [], []};


%% -------------------------------------------------------------------------- %%
% fixation 
cfg.fixation.type = 'cross'; % can also be 'dot' or 'bestFixation'
cfg.fixation.xDisplacement = 0; % horizontal offset from window center
cfg.fixation.yDisplacement = 0; % vertical offset from window center
cfg.fixation.color = [255 255 255];
cfg.fixation.width = 1; % in degrees of visual angle
cfg.fixation.lineWidthPix = 5; % width of the lines in pixel

%% -------------------------------------------------------------------------- %%
% aperture
% mostly relevant for retinotopy scripts but can be reused for other types of 
%  experiments where an aperture is needed
cfg.aperture.type = 'none'; % 'bar', 'wedge', 'ring', 'circle' 

%% -------------------------------------------------------------------------- %%
% cfg.audio
cfg.audio.do = false; % set to true if you are going to play some sounds

cfg.audio.requestedLatency = 3;
cfg.audio.fs 44800; % sampling frequency 
cfg.audio.channels = 2; % number of auditory channels
cfg.audio.initVolume = 1;
cfg.audio.repeat = 1;
cfg.audio.startCue = 0;
cfg.audio.waitForDevice = 1;

%% -------------------------------------------------------------------------- %%
% eyetracker
cfg.eyeTracker.do = false; % set to true if you are using an eyelink eyetracker
cfg.eyeTracker.defaultCalibration = true;
cfg.eyeTracker.backgroundColor = [192 192 192];
cfg.eyeTracker.fontColor = [0 0 0];
cfg.eyeTracker.calibrationTargetColor = [0 0 0];
cfg.eyeTracker.calibrationTargetSize = 1;
cfg.eyeTracker.calibrationTargetWidth = 0.5;
cfg.eyeTracker.displayCalResults = 1;

%% -------------------------------------------------------------------------- %%
% cfg.mri
cfg.bids.mri.repetitionTime

%% -------------------------------------------------------------------------- %%
								SET BY initPTB
%% -------------------------------------------------------------------------- %%

%% -------------------------------------------------------------------------- %%
% cfg.screen
% all the following will be initialised by initPTB
cfg.screen.idx % screen index
cfg.screen.win % window index
cfg.screen.winRect % rectangle definition of the window 
cfg.screen.winWidth
cfg.screen.winHeight
cfg.screen.center % [x y] ; pixel coordinate of the window center
cfg.screen.FOV % width of the field of view in degrees of visual angle
cfg.screen.ppd % pixel per degree
cfg.screen.ifi % inter frame interval 
cfg.screen.monRefresh % monitor refresh rate ; 1 / ifi

%% -------------------------------------------------------------------------- %%
% cfg.audio
cfg.audio.requestOffsetTime = 1;
cfg.audio.reqsSampleOffset
cfg.audio.pushSize  
cfg.audio.playbackMode = 1;
cfg.audio.devIdx = [];
cfg.audio.pahandle

%% -------------------------------------------------------------------------- %%
% operating system information collected by initPTB
cfg.software.os 
cfg.software.name = 'Psychtoolbox';
cfg.software.RRID = 'SCR_002881';
cfg.software.version % psychtoolbox version
cfg.software.runsOn % matlab or octave and version number
```

##  2. <a name='Settingupkeyboards'></a>Setting up keyboards

To select a specific keyboard to be used by the experimenter or the participant, you need to know
the value assigned by PTB to each keyboard device.

To know this copy-paste this on the command window:

``` matlab
[keyboardNumbers, keyboardNames] = GetKeyboardIndices;

disp(keyboardNumbers);
disp(keyboardNames);
```

You can then assign a specific device number to the main keyboard or the response box in the `cfg` structure

-   `cfg.keyboard.responseBox` would be the device number of the device used by the participant to give his/her
response: like the button box in the scanner or a separate keyboard for a behavioral experiment
-   `cfg.keyboard.keyboard` would be the device number of the keyboard on which the experimenter will type or
press the keys necessary to start or abort the experiment.

`cfg.keyboard.responseBox` and `cfg.keyboard.keyboard` can be different or the same.

Using empty vectors (ie `[]`) or a negative value for those means that you will let PTB find and use the default device.

##  3. <a name='functionsdescriptions'></a>functions descriptions

The main functions of the toolbox are described [here](./10_functions_descriptions.md).

##  4. <a name='Annexes'></a>Annexes

###  4.1. <a name='ExperimenttemplateWIP'></a>Experiment template [ WIP ]

Will be moved to a different repository

###  4.2. <a name='devSandboxstand-alone'></a>devSandbox (stand-alone)

Will be moved to a different repository

This script is a stand-alone function that can be useful as a sandbox to develop the PTB audio/visual stimulation of your experiment. No input/output required.

Here, a tutorial from https://peterscarfe.com/contrastgratingdemo.html is provided for illustrative purpose (notice that some variable names are updated to our code style). For your use, you will delete that part.

It is composed of two parts:
 - a fixed structure that will initialize and close PTB in 'debug mode'
    (`PsychDebugWindowConfiguration`, `SkipSyncTests`)
 - the actual sandbox where to set your dynamic variables (the stimulation
   parameters) and the 'playground' where to develop the stimulation code

 When you are happy with it, ideally you will move the vars in `setParameters.m` and the stimulation code in a separate function in `my-experiment-folder/subfun`. The code style and variable names are the same used in `cpp-lln-lab/CPP_PTB` github repo, therefore it should be easy to move everything in your experiment scripts (see the template that is annexed in `cpp-lln-lab/CPP_PTB`).
