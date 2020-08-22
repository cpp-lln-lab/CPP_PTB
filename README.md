[![](https://img.shields.io/badge/Octave-CI-blue?logo=Octave&logoColor=white)](https://github.com/cpp-lln-lab/CPP_PTB/actions)
![](https://github.com/cpp-lln-lab/CPP_PTB/workflows/CI/badge.svg) 

[![Build Status](https://travis-ci.com/cpp-lln-lab/CPP_PTB.svg?branch=master)](https://travis-ci.com/cpp-lln-lab/CPP_PTB)

[![codecov](https://codecov.io/gh/cpp-lln-lab/CPP_PTB/branch/master/graph/badge.svg)](https://codecov.io/gh/cpp-lln-lab/CPP_PTB)

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-3-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

# CPP_PTB

<!-- vscode-markdown-toc -->
* 1. [Requirements](#Requirements)
* 2. [Code guidestyle](#Codeguidestyle)
* 3. [How to install](#Howtoinstall)
	* 3.1. [Download with git](#Downloadwithgit)
	* 3.2. [Add as a submodule](#Addasasubmodule)
		* 3.2.1. [Example for submodule usage](#Exampleforsubmoduleusage)
	* 3.3. [Direct download](#Directdownload)
* 4. [Setting up keyboards](#Settingupkeyboards)
* 5. [Structure](#Structure)
* 6. [Annexes](#Annexes)
	* 6.1. [Experiment template [ WIP ]](#ExperimenttemplateWIP)
	* 6.2. [devSandbox (stand-alone)](#devSandboxstand-alone)
* 7. [Contributors ✨](#Contributors)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->


This is the Crossmodal Perception and Plasticity lab (CPP) PsychToolBox (PTB) toolbox.

Those functions are mostly wrappers around some PTB functions to facilitate their use and to have a codebase to facilitate their reuse.

##  1. <a name='Requirements'></a>Requirements

Make sure that the following toolboxes are installed and added to the matlab / octave path.

For instructions see the following links:

| Requirements                                             | Used version |
|----------------------------------------------------------|--------------|
| [PsychToolBox](http://psychtoolbox.org/)                 | >=3.0.14     |
| [Matlab](https://www.mathworks.com/products/matlab.html) | >=2015b      |
| or [octave](https://www.gnu.org/software/octave/)        | 4.?          |

The exact version required for this to work but it is known to work with:
-   matlab 2015b or octave 4.2.2 and PTB 3.0.14.

##  2. <a name='Codeguidestyle'></a>Code guidestyle

We use the `camelCase` to more easily differentiates our functions from the ones from PTB that use a `PascalCase`.
We use the following regular expression for function names: `[a-z]+(([A-Z]|[0-9]){1}[a-z]+)*`.

We keep the McCabe complexity as reported by the [check_my_code function](https://github.com/Remi-Gau/check_my_code) below 15.

We use the [MISS_HIT linter](https://florianschanda.github.io/miss_hit/style_checker.html) to automatically fix some linting issues. The code style and quality is also checked during the continuous integration.

##  3. <a name='Howtoinstall'></a>How to install

###  3.1. <a name='Downloadwithgit'></a>Download with git

``` bash
cd fullpath_to_directory_where_to_install
# use git to download the code
git clone https://github.com/cpp-lln-lab/CPP_PTB.git
# move into the folder you have just created
cd CPP_PTB
# add the src folder to the matlab path and save the path
matlab -nojvm -nosplash -r "addpath(fullfile(pwd)); savepath ();"
```

Then get the latest commit:
```bash
# from the directory where you downloaded the code
git pull origin master
```

To work with a specific version, create a branch at a specific version tag number
```bash
# creating and checking out a branch that will be calle version1 at the version tag v0.0.1
git checkout -b version1 v0.0.1
```

###  3.2. <a name='Addasasubmodule'></a>Add as a submodule

Add it as a submodule in the repo you are working on.

``` bash
cd fullpath_to_directory_where_to_install
# use git to download the code
git submodule add https://github.com/cpp-lln-lab/CPP_PTB.git
# move into the folder you have just created
cd CPP_PTB
# add the src folder to the matlab path and save the path
matlab -nojvm -nosplash -r "addpath(fullfile(pwd))"
```

To get the latest commit you then need to update the submodule with the information
on its remote repository and then merge those locally.
```bash
git submodule update --remote --merge
```

Remember that updates to submodules need to be committed as well.

####  3.2.1. <a name='Exampleforsubmoduleusage'></a>Example for submodule usage

So say you want to clone a repo that has some nested submodules, then you would type this to get the content of all the submodules at once (here with my experiment repo):
``` bash
git clone --recurse-submodules https://github.com/user_name/yourExperiment.git
```
This would be the way to do it "by hand"

```bash
# clone the repo
git clone https://github.com/user_name/yourExperiment.git

# go into the directory
cd yourExperiment

# initialize and get the content of the first level of submodules  (CPP_PTB and CPP_BIDS)
git submodule init
git submodule update

# get the nested submodules JSONio and BIDS-matlab for CPP_BIDS
git submodule foreach --recursive 'git submodule init'
git submodule foreach --recursive 'git submodule update'
```

###  3.3. <a name='Directdownload'></a>Direct download

Download the code. Unzip. And add to the matlab path.

Pick a specific version:

https://github.com/cpp-lln-lab/CPP_PTB/releases

Or take the latest commit (NOT RECOMMENDED):

https://github.com/cpp-lln-lab/CPP_PTB/archive/master.zip

##  4. <a name='Settingupkeyboards'></a>Setting up keyboards

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

##  5. <a name='Structure'></a>Structure

The `cfg` structure is where most of the information about your experiment will be defined.

Below we try to outline what it contains.

```matlab

cfg.testingDevice = 'pc';

% cfg.color
cfg.keyboard.keyboard = [];
cfg.keyboard.responseBox = [];
cfg.keyboard.responseKey = {};
cfg.keyboard.escapeKey = 'ESCAPE';

% cfg.debug
cfg.debug.do = true;
cfg.debug.transpWin = true;
cfg.debug.smallWin = true;

% cfg.text
cfg.text.font
cfg.text.size
cfg.text.style

% cfg.color
cfg.color.background

% cfg.screen
cfg.screen.monitorWidth
cfg.screen.monitorDistance
cfg.screen.idx
cfg.screen.win
cfg.screen.winRect
cfg.screen.winWidth
cfg.screen.winHeight
cfg.screen.center
cfg.screen.FOV
cfg.screen.ppd
cfg.screen.ifi
cfg.screen.monRefresh

% cfg.audio
cfg.audio.do
cfg.audio.pahandle
cfg.audio.devIdx
cfg.audio.playbackMode
cfg.audio.requestedLatency
cfg.audio.fs
cfg.audio.channels
cfg.audio.initVolume
cfg.audio.pushSize  
cfg.audio.requestOffsetTime
cfg.audio.reqsSampleOffset

% cfg.mri
cfg.mri.repetitionTime
cfg.mri.triggerNb
cfg.mri.triggerKey
```

##  6. <a name='Annexes'></a>Annexes

###  6.1. <a name='ExperimenttemplateWIP'></a>Experiment template [ WIP ]

###  6.2. <a name='devSandboxstand-alone'></a>devSandbox (stand-alone)

This script is a stand-alone function that can be useful as a sandbox to develop the PTB audio/visual stimulation of your experiment. No input/output required.

Here, a tutorial from https://peterscarfe.com/contrastgratingdemo.html is provided for illustrative purpose (notice that some variable names are updated to our code style). For your use, you will delete that part.

It is composed of two parts:
 - a fixed structure that will initialize and close PTB in 'debug mode'
    (`PsychDebugWindowConfiguration`, `SkipSyncTests`)
 - the actual sandbox where to set your dynamic variables (the stimulation
   parameters) and the 'playground' where to develop the stimulation code

 When you are happy with it, ideally you will move the vars in `setParameters.m` and the stimulation code in a separate function in `my-experiment-folder/subfun`. The code style and variable names are the same used in `cpp-lln-lab/CPP_PTB` github repo, therefore it should be easy to move everything in your experiment scripts (see the template that is annexed in `cpp-lln-lab/CPP_PTB`).

##  7. <a name='Contributors'></a>Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://remi-gau.github.io/"><img src="https://avatars3.githubusercontent.com/u/6961185?v=4" width="100px;" alt=""/><br /><sub><b>Remi Gau</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=Remi-Gau" title="Code">💻</a> <a href="#design-Remi-Gau" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=Remi-Gau" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/marcobarilari"><img src="https://avatars3.githubusercontent.com/u/38101692?v=4" width="100px;" alt=""/><br /><sub><b>marcobarilari</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=marcobarilari" title="Code">💻</a> <a href="#design-marcobarilari" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=marcobarilari" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/CerenB"><img src="https://avatars1.githubusercontent.com/u/10451654?v=4" width="100px;" alt=""/><br /><sub><b>CerenB</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=CerenB" title="Code">💻</a> <a href="#design-CerenB" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=CerenB" title="Documentation">📖</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/pulls?q=is%3Apr+reviewed-by%3ACerenB" title="Reviewed Pull Requests">👀</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
