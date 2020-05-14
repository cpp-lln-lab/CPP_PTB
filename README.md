# CPP_PTB
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

This is List of Crossmodal Perpeption and Plasticity lab (CPP) PsychToolBox (PTB) toolbox.

Those functions are mostly wrappers around some PTB functions to facilitate their use and to have a codebase to facilitate their reuse.


## Requirements

Make sure that the following toolboxes are installed and added to the matlab / octave path.

For instructions see the following links:

| Requirements                                             | Used version |
|----------------------------------------------------------|--------------|
| [PsychToolBox](http://psychtoolbox.org/)  Duuuuhh        | >3.0.13      |
| [Matlab](https://www.mathworks.com/products/matlab.html) | 201??        |
| or [octave](https://www.gnu.org/software/octave/)        | 4.?          |

The exact version required for this to work but it is known to work with:
-   matlab 2017a or octave 4.2.2 and PTB 3.0.16.

## Code guidestyle

We use the `camelCase` to more easily differentiates our functions from the ones from PTB that use a `PascalCase`.

We keep the McCabe complexity as reported by the [check_my_code function](https://github.com/Remi-Gau/matlab_checkcode) below 15.

## How to install




## Structure and function details

<!-- ### setParameters -->

### initPTB

This will initialize PsychToolBox
-   screen
  - the windon opened takes the whole screen by default
  - set in debug mode with window transparency if necessary
  - can skip synch test if you ask for it (nicely)
  - gets the flip interval
  - computes the pixel per degree of visual angle
  - set font details
-   keyboard
-   sound

### testKeyboards
Checks that the keyboards asked for properly connected.

If no key is pressed on the correct keyboard after the timeOut time this exits with an error.

### cleanUp
A wrapper function to close all windows, ports, show mouse cursor, close keyboard queues
and give access back to the keyboards.

### getResponse

It is wrapper function to use `KbQueue` which is definitely what you should used to collect responses.

You can easily collect responses while running some other code at the same time.

It will only take responses from the `response box` which can simply be the "main keyboard" or
another keyboard connected to the computer or the response box that the participant is using.

You can use it in a way so that it only takes responses from certain keys and ignore others (like
the triggers from an MRI scanner).

If you want to know more on how to use it check its help section and the `CPP_getResponseDemo.m`.

To select a specific keyboard to be used by the experimenter or the participant, you need to know
the value assigned by PTB to each keyboard device.

To know this copy-paste this on the command window:

```
[keyboardNumbers, keyboardNames] = GetKeyboardIndices;

keyboardNumbers
keyboardNames
```

### deg2Pix

For a given field value in degrees of visual angle in the input `structure`,
this computes its value in pixel using the pixel per degree value of the `cfg` structure
and returns a structure with an additional field with Pix suffix holding that new value.

### drawFixationCross

Define the parameters of the fixation cross in `cfg` and `expParameters` and this does the rest.

### pressSpace4me

Use that to stop your script and only restart when the space bar is pressed.










## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://remi-gau.github.io/"><img src="https://avatars3.githubusercontent.com/u/6961185?v=4" width="100px;" alt=""/><br /><sub><b>Remi Gau</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=Remi-Gau" title="Code">💻</a> <a href="#design-Remi-Gau" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=Remi-Gau" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/marcobarilari"><img src="https://avatars3.githubusercontent.com/u/38101692?v=4" width="100px;" alt=""/><br /><sub><b>marcobarilari</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=marcobarilari" title="Code">💻</a> <a href="#design-marcobarilari" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=marcobarilari" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
