<!-- lint disable -->

**Cite it**

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4007672.svg)](https://doi.org/10.5281/zenodo.4007672)

**Unit tests and coverage**

[![](https://img.shields.io/badge/Octave-CI-blue?logo=Octave&logoColor=white)](https://github.com/cpp-lln-lab/CPP_PTB/actions)
![](https://github.com/cpp-lln-lab/CPP_PTB/workflows/CI/badge.svg)

[![Build Status](https://travis-ci.com/cpp-lln-lab/CPP_PTB.svg?branch=master)](https://travis-ci.com/cpp-lln-lab/CPP_PTB)

[![codecov](https://codecov.io/gh/cpp-lln-lab/CPP_PTB/branch/master/graph/badge.svg)](https://codecov.io/gh/cpp-lln-lab/CPP_PTB)

**Contributors**

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All Contributors](https://img.shields.io/badge/all_contributors-3-orange.svg?style=flat-square)](#contributors-)

<!-- ALL-CONTRIBUTORS-BADGE:END -->

# CPP_PTB

<!-- TOC -->

-   [CPP_PTB](#cpp_ptb)
    -   [Requirements](#requirements)
    -   [Documentation](#documentation)
    -   [Content](#content)
    -   [How to install](#how-to-install)
        -   [Download with git](#download-with-git)
        -   [Add as a submodule](#add-as-a-submodule)
            -   [Example for submodule usage](#example-for-submodule-usage)
        -   [Direct download](#direct-download)
        -   [Add CPP_PTB globally to the matlab path](#add-cpp_ptb-globally-to-the-matlab-path)
    -   [Code style guide](#code-style-guide)
    -   [Unit tests](#unit-tests)
    -   [Contributors ✨](#contributors-)

<!-- /TOC -->

<!-- lint enable -->

This is the Crossmodal Perception and Plasticity lab (CPP) PsychToolBox (PTB)
toolbox.

Those functions are mostly wrappers around some PTB functions to facilitate
their use and their reuse (#DontRepeatYourself)

## Requirements

Make sure that the following toolboxes are installed and added to the matlab /
octave path.

For instructions see the following links:

<!-- lint disable -->

| Requirements                                             | Used version |
| -------------------------------------------------------- | ------------ |
| [PsychToolBox](http://psychtoolbox.org/)                 | >=3.0.14     |
| [Matlab](https://www.mathworks.com/products/matlab.html) | >=2015b      |
| or [Octave](https://www.gnu.org/software/octave/)        | 4.?          |

<!-- lint enable -->

Tested:

-   matlab 2015b or octave 4.2.2 and PTB 3.0.14.

## Documentation

All the documentation is accessible [here](./docs/00-index.md).

## Content

```bash
├── demos # quick demo of how to use some functions
├── docs # documentation
├── manualTests # all the tests that cannot be automated (yet)
├── src # actual code of the CPP_PTB
│   ├── aperture # function related to create apertur (circle, wedge, bar...)
│   ├── dot # functions to simplify the creations of RDK
│   ├── errors # all error functions
│   ├── fixation # to create fixation cross, dots
│   ├── keyboard # to collect responses, abort experiment...
│   ├── randomization # functions to help with trial randomization
│   └── utils # set of general functions
└── tests # all the tests that that can be run by github actions
```

## How to install

The easiest way to use this repository is to create a new repository by using
the
[template PTB experiment repository](https://github.com/cpp-lln-lab/template_PTB_experiment):
this creates a new repository on your github account with all the basic folders,
files and submodules already set up. You only have to then clone the repository
and you are good to go.

### Download with git

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

### Add as a submodule

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

### Direct download

Download the code. Unzip. And add to the matlab path.

Pick a specific version from
[here](https://github.com/cpp-lln-lab/CPP_PTB/releases).

Or take
[the latest commit](https://github.com/cpp-lln-lab/CPP_PTB/archive/master.zip) -
NOT RECOMMENDED.

### Add CPP_PTB globally to the matlab path

This is NOT RECOMMENDED as this might create conflicts if you use different
versions of CPP_PTB as sub-modules.

Also note that this might not work at all if you have not set a command line
alias to start Matlab from a terminal window by just typing `matlab`. :wink:

```bash
# from within the CPP_PTB folder
matlab -nojvm -nosplash -r "addpath(genpath(fullfile(pwd, 'src'))); savepath(); path(); exit();"
```

## Code style guide

We use the `camelCase` to more easily differentiates our functions from the ones
from PTB that use a `PascalCase`.

In practice, we use the following regular expression for function names:
`[a-z]+(([A-Z]|[0-9]){1}[a-z]+)*`.

> Regular expressions look scary but are SUPER useful to sort through filenames:
>
> -   A quick [intro to regular expression](https://www.rexegg.com/)
>
> -   And many websites allow you to "design and test" your regular expression:
>     -   [regexper](https://regexper.com/#%5Ba-z%5D%2B%28%28%5BA-Z%5D%7C%5B0-9%5D%29%7B1%7D%5Ba-z%5D%2B%29)
>     -   ...

We keep the McCabe complexity below 15 as reported by the
[check_my_code function](https://github.com/Remi-Gau/check_my_code) or the
[MISS_HIT code checker](https://florianschanda.github.io/miss_hit). A couple of
code quality metrics are also checked automatically by MISS_HIT (avoiding
functions with too many nested `if` blocks).

We use the
[MISS_HIT linter](https://florianschanda.github.io/miss_hit/style_checker.html)
to automatically fix some linting issues.

The code style and quality is also checked during the
[continuous integration](./.travis.yml).

## Unit tests

Unit tests are run with the mox unit toolbox and automated with github action on
Octave.

## Contributors ✨

Thanks goes to these wonderful people
([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->

<!-- prettier-ignore-start -->

<!-- markdownlint-disable -->

<table>
  <tr>
    <td align="center"><a href="https://remi-gau.github.io/"><img src="https://avatars3.githubusercontent.com/u/6961185?v=4" width="100px;" alt=""/><br /><sub><b>Remi Gau</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=Remi-Gau" title="Code">💻</a> <a href="#design-Remi-Gau" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=Remi-Gau" title="Documentation">📖</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/issues?q=author%3ARemi-Gau" title="Bug reports">🐛</a> <a href="#userTesting-Remi-Gau" title="User Testing">📓</a> <a href="#ideas-Remi-Gau" title="Ideas, Planning, & Feedback">🤔</a> <a href="#infra-Remi-Gau" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="#maintenance-Remi-Gau" title="Maintenance">🚧</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=Remi-Gau" title="Tests">⚠️</a> <a href="#question-Remi-Gau" title="Answering Questions">💬</a></td>
    <td align="center"><a href="https://github.com/marcobarilari"><img src="https://avatars3.githubusercontent.com/u/38101692?v=4" width="100px;" alt=""/><br /><sub><b>marcobarilari</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=marcobarilari" title="Code">💻</a> <a href="#design-marcobarilari" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=marcobarilari" title="Documentation">📖</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/issues?q=author%3Amarcobarilari" title="Bug reports">🐛</a> <a href="#userTesting-marcobarilari" title="User Testing">📓</a> <a href="#ideas-marcobarilari" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/CerenB"><img src="https://avatars1.githubusercontent.com/u/10451654?v=4" width="100px;" alt=""/><br /><sub><b>CerenB</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=CerenB" title="Code">💻</a> <a href="#design-CerenB" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=CerenB" title="Documentation">📖</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/pulls?q=is%3Apr+reviewed-by%3ACerenB" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=CerenB" title="Tests">⚠️</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/issues?q=author%3ACerenB" title="Bug reports">🐛</a> <a href="#userTesting-CerenB" title="User Testing">📓</a> <a href="#ideas-CerenB" title="Ideas, Planning, & Feedback">🤔</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->

<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the
[all-contributors](https://github.com/all-contributors/all-contributors)
specification. Contributions of any kind welcome!
