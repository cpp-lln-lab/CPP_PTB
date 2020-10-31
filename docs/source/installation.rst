************
Installation
************

Requirements
============

Make sure that the following toolboxes are installed and added to the matlab /
octave path.

For instructions see the following links:

| Requirements                                             | Used version |
| -------------------------------------------------------- | ------------ |
| [PsychToolBox](http://psychtoolbox.org/)                 | >=3.0.14     |
| [Matlab](https://www.mathworks.com/products/matlab.html) | >=2015b      |
| or [Octave](https://www.gnu.org/software/octave/)        | 4.?          |

Tested:

-   matlab 2015b or octave 4.2.2 and PTB 3.0.14.

How to install
==============

The easiest way to use this repository is to create a new repository by using
the
[template PTB experiment repository](https://github.com/cpp-lln-lab/template_PTB_experiment):
this creates a new repository on your github account with all the basic folders,
files and submodules already set up. You only have to then clone the repository
and you are good to go.

Download with git
*****************

```bash
cd fullpath_to_directory_where_to_install
# use git to download the code
git clone https://github.com/cpp-lln-lab/CPP_PTB.git
# move into the folder you have just created
cd CPP_PTB
```

Then get the latest commit to stay up to date:

```bash
# from the directory where you downloaded the code
git pull origin master
```

To work with a specific version, create a branch at a specific version tag
number

```bash
# creating and checking out a branch that will be called version1 at the version tag v1.0.0
git checkout -b version1 v1.0.0
```

Add as a submodule
******************

Add it as a submodule in the repo you are working on.

```bash
cd fullpath_to_directory_where_to_install
# use git to download the code
git submodule add https://github.com/cpp-lln-lab/CPP_PTB.git
```

To get the latest commit you then need to update the submodule with the
information on its remote repository and then merge those locally.

```bash
git submodule update --remote --merge
```

Remember that updates to submodules need to be committed as well.

#### Example for submodule usage

So say you want to clone a repo that has some nested submodules, then you would
type this to get the content of all the submodules at once (here with my
experiment repo):

```bash
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

Direct download
***************

Download the code. Unzip. And add to the matlab path.

Pick a specific version from
[here](https://github.com/cpp-lln-lab/CPP_PTB/releases).

Or take
[the latest commit](https://github.com/cpp-lln-lab/CPP_PTB/archive/master.zip) -
NOT RECOMMENDED.

Add CPP_PTB globally to the matlab path
----

This is NOT RECOMMENDED as this might create conflicts if you use different
versions of CPP_PTB as sub-modules.

Also note that this might not work at all if you have not set a command line
alias to start Matlab from a terminal window by just typing `matlab`. :wink:

```bash
# from within the CPP_PTB folder
matlab -nojvm -nosplash -r "addpath(genpath(fullfile(pwd, 'src'))); savepath(); path(); exit();"
```
