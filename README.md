[![Documentation Status: stable](https://readthedocs.org/projects/cpp-ptb/badge/?version=stable)](https://cpp-ptb.readthedocs.io/en/stable/?badge=stable)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4007672.svg)](https://doi.org/10.5281/zenodo.4007672)
[![](https://img.shields.io/badge/Octave-CI-blue?logo=Octave&logoColor=white)](https://github.com/cpp-lln-lab/CPP_PTB/actions)
![](https://github.com/cpp-lln-lab/CPP_PTB/workflows/CI/badge.svg)
[![codecov](https://codecov.io/gh/cpp-lln-lab/CPP_PTB/branch/master/graph/badge.svg)](https://codecov.io/gh/cpp-lln-lab/CPP_PTB)
[![All Contributors](https://img.shields.io/badge/all_contributors-5-orange.svg?style=flat-square)](#contributors-)

# CPP_PTB

- [CPP_PTB](#cpp_ptb)
  - [Documentation](#documentation)
  - [Content](#content)
  - [Contributing](#contributing)
  - [Contributors ✨](#contributors-)

This is the Crossmodal Perception and Plasticity lab (CPP) PsychToolBox (PTB)
toolbox.

Those functions are mostly wrappers around some PTB functions to facilitate
their use and their reuse (#DontRepeatYourself)

## Documentation

All the documentation and installtion information is accessible
[here](https://cpp-ptb.readthedocs.io/en/stable/index.html#).

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

## Contributing

Feel free to open issues to report a bug and ask for improvements.

If you want to contribute, have a look at our
[contributing guidelines](https://github.com/cpp-lln-lab/.github/blob/main/CONTRIBUTING.md)
that are meant to guide you and help you get started. If something is not clear
or you get stuck: it is more likely we did not do good enough a job at
explaining things. So do not hesitate to open an issue, just to ask for
clarification.

## Contributors ✨

Thanks goes to these wonderful people
([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://remi-gau.github.io/"><img src="https://avatars3.githubusercontent.com/u/6961185?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Remi Gau</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=Remi-Gau" title="Code">💻</a> <a href="#design-Remi-Gau" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=Remi-Gau" title="Documentation">📖</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/issues?q=author%3ARemi-Gau" title="Bug reports">🐛</a> <a href="#userTesting-Remi-Gau" title="User Testing">📓</a> <a href="#ideas-Remi-Gau" title="Ideas, Planning, & Feedback">🤔</a> <a href="#infra-Remi-Gau" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="#maintenance-Remi-Gau" title="Maintenance">🚧</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=Remi-Gau" title="Tests">⚠️</a> <a href="#question-Remi-Gau" title="Answering Questions">💬</a></td>
    <td align="center"><a href="https://github.com/marcobarilari"><img src="https://avatars3.githubusercontent.com/u/38101692?v=4?s=100" width="100px;" alt=""/><br /><sub><b>marcobarilari</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=marcobarilari" title="Code">💻</a> <a href="#design-marcobarilari" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=marcobarilari" title="Documentation">📖</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/issues?q=author%3Amarcobarilari" title="Bug reports">🐛</a> <a href="#userTesting-marcobarilari" title="User Testing">📓</a> <a href="#ideas-marcobarilari" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/CerenB"><img src="https://avatars1.githubusercontent.com/u/10451654?v=4?s=100" width="100px;" alt=""/><br /><sub><b>CerenB</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=CerenB" title="Code">💻</a> <a href="#design-CerenB" title="Design">🎨</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=CerenB" title="Documentation">📖</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/pulls?q=is%3Apr+reviewed-by%3ACerenB" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=CerenB" title="Tests">⚠️</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/issues?q=author%3ACerenB" title="Bug reports">🐛</a> <a href="#userTesting-CerenB" title="User Testing">📓</a> <a href="#ideas-CerenB" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://github.com/fedefalag"><img src="https://avatars.githubusercontent.com/u/50373329?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Fede F.</b></sub></a><br /><a href="#ideas-fedefalag" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=fedefalag" title="Code">💻</a> <a href="#content-fedefalag" title="Content">🖋</a></td>
    <td align="center"><a href="https://github.com/iqrashahzad14"><img src="https://avatars.githubusercontent.com/u/75671348?v=4?s=100" width="100px;" alt=""/><br /><sub><b>iqrashahzad14</b></sub></a><br /><a href="https://github.com/cpp-lln-lab/CPP_PTB/issues?q=author%3Aiqrashahzad14" title="Bug reports">🐛</a> <a href="https://github.com/cpp-lln-lab/CPP_PTB/commits?author=iqrashahzad14" title="Tests">⚠️</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the
[all-contributors](https://github.com/all-contributors/all-contributors)
specification. Contributions of any kind welcome!
