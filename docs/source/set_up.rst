Set up
******

The CFG structure
=================

The ``cfg`` structure is where most of the information about your experiment will
be defined.

Below we try to outline what it contains.

Some of those fields you can set yourself while some others will be created and
filled after running ``setDefaultsPTB.m`` and ``initPTB.m``.

  - ``setDefaultsPTB.m`` sets some default values for things about your experiment
    that that do not "depend" on your system or that PTB cannot "know". For
    example the width of the screen in cm or the dimensions of the fixation
    cross you want to use...

  - ``initPTB.m`` will fill in the fields that ARE system dependent like the
    screen refresh rate, the reference of the window that PTB opened and where
    to flip stimulus to. When it runs, ``initPTB.m`` will call ``setDefaultsPTB.m``
    to make sure that all the required fields are non-empty.

If no value is provided below, it means that there is no set default (or that the
`initPTB` takes care of it).

Fields set ``setDefaultsPTB``
-----------------------------

.. code-block:: matlab

    cfg.testingDevice = 'pc';

Other options include:

    - ``'mri'``
    - ``'eeg'``
    - ``'meg'``

cfg.keyboard
++++++++++++

.. code-block:: matlab

    cfg.keyboard.keyboard = [];         % device index for the main keyboard
                                          % (that of the experimenter)
    cfg.keyboard.responseBox = [];      % device index used by the participants
    cfg.keyboard.responseKey = {};      % list the keys that PTB should "listen" to when
                                          % using KbQueue to collect responses ;
                                          % if empty PTB will listen to all key presses
    cfg.keyboard.escapeKey = 'ESCAPE';  % key to press to escape


cfg.debug
+++++++++

.. code-block:: matlab

    cfg.debug.do = true;        % if true this will make less PTB tolerant with
                                  % bad synchronisation
    cfg.debug.transpWin = true; % makes the stimulus windows semi-transparent:
                                  % useful when designing your experiment
    cfg.debug.smallWin = true;  % open a small window and not a full screen window ;
                                  % can be useful for debugging

cfg.text
++++++++

.. code-block:: matlab

    cfg.text.font = 'Courier New';
    cfg.text.size = 18;
    cfg.text.style = 1; % bold


cfg.color
+++++++++

.. code-block:: matlab

    cfg.color.background = [0 0 0]; % [r g b] each in 0-255

cfg.screen
++++++++++

.. code-block:: matlab

    cfg.screen.monitorWidth = 42;       % in cm
    cfg.screen.monitorDistance = 134;   % in cm
    cfg.screen.resolution = {[], [], []};


cfg.fixation
++++++++++++

.. code-block:: matlab

    cfg.fixation.type = 'cross';    % can also be 'dot' or 'bestFixation'
    cfg.fixation.xDisplacement = 0; % horizontal offset from window center
    cfg.fixation.yDisplacement = 0; % vertical offset from window center
    cfg.fixation.color = [255 255 255];
    cfg.fixation.width = 1;         % in degrees of visual angle
    cfg.fixation.lineWidthPix = 5;  % width of the lines in pixel

cfg.aperture
++++++++++++

Mostly relevant for retinotopy scripts but can be reused for other types of
experiments where an aperture is needed.

.. code-block:: matlab

    cfg.aperture.type = 'none';

Other options include:

  - ``'bar'``
  - ``'wedge'``
  - ``'ring'``
  - ``'circle'``


cfg.audio
+++++++++

.. code-block:: matlab

    cfg.audio.do = false;            % set to true if you are going to play some sounds
    cfg.audio.requestedLatency = 3;
    cfg.audio.fs 44100;              % sampling frequency
    cfg.audio.channels = 2;          % number of auditory channels
    cfg.audio.initVolume = 1;
    cfg.audio.repeat = 1;
    cfg.audio.startCue = 0;
    cfg.audio.waitForDevice = 1;

Fields set by ``initPTB``
-------------------------

cfg.screen
++++++++++

.. code-block:: matlab

    cfg.screen.idx          % screen index
    cfg.screen.win          % window index
    cfg.screen.winRect      % rectangle definition of the window
    cfg.screen.winWidth
    cfg.screen.winHeight
    cfg.screen.center       % [x y] ; pixel coordinate of the window center
    cfg.screen.FOV          % width of the field of view in degrees of visual angle
    cfg.screen.ppd          % pixel per degree
    cfg.screen.ifi          % inter frame interval
    cfg.screen.monRefresh   % monitor refresh rate ; 1 / ifi


cfg.audio
+++++++++

.. code-block:: matlab

    cfg.audio.requestOffsetTime = 1;
    cfg.audio.reqsSampleOffset
    cfg.audio.pushSize
    cfg.audio.playbackMode = 1;
    cfg.audio.devIdx = [];
    cfg.audio.pahandle


operating system information
++++++++++++++++++++++++++++

.. code-block:: matlab

    cfg.software.os
    cfg.software.name = 'Psychtoolbox';
    cfg.software.RRID = 'SCR_002881';
    cfg.software.version % psychtoolbox version
    cfg.software.runsOn % matlab or octave and version number


Setting up keyboards
====================

To select a specific keyboard to be used by the experimenter or the participant,
you need to know the value assigned by PTB to each keyboard device.

To know this copy-paste this on the command window:

.. code-block:: matlab

    [keyboardNumbers, keyboardNames] = GetKeyboardIndices;

    disp(keyboardNumbers);
    disp(keyboardNames);


You can then assign a specific device number to the main keyboard or the
response box in the ``cfg`` structure:

  - ``cfg.keyboard.responseBox`` would be the device number of the device used by
    the participant to give his/her response: like the button box in the scanner
    or a separate keyboard for a behavioral experiment

  - ``cfg.keyboard.keyboard`` would be the device number of the keyboard on which
    the experimenter will type or press the keys necessary to start or abort the
    experiment.

``cfg.keyboard.responseBox`` and ``cfg.keyboard.keyboard`` can be different or the
same.

Using empty vectors (like ``[]``) or a negative value for those means that you will
let PTB find and use the default device.
