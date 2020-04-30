# CPP_PTB

List of PsychToolBox (PTB) related functions for the Crossmodal Perpcetion and Plasticity lab (CPP)

Most of the functions here are mostly wrappers around some PTB functions to facilitate their use and to have a codebase to facilitate their reuse.

## Code guidestyle

We use the `pascalCase` to more easily differentiates our functions from the ones from PTB that use a `CamelCase`.

## Structure and function details

### setParameters

### initPTB

### getResponse
It is wrapper function to use KbQueue which is definitely what you should used to collect responses.

You can easily collect responses while running some other code at the same time.

It will only take responses from the `response box` which can simply be the "main keyboard" or another keyboard connected to the computer or the response box that the participant is using.

You can use it in a way so that it only takes responses from certain keys.

If you want to know more on how to use it check its help section and the `CPP_getResponseDemo.m`.

To select a specific keyboard to be used by experimenter/participant, you need to know the assigned MATLAB value. To copy-paste this on the command wuindow:

```
[keyboardNumbers, keyboardNames] = GetKeyboardIndices;

keyboardNumbers
keyboardNames
```


### cleanUp
