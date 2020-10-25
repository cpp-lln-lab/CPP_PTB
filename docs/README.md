# Setting up sphinx to create a matlab doc

## Set up virtual environment

```bash
virtualenv -p python3 cpp_ptb
source cpp_ptb/bin/activate

pip install -r requirements.txt
```

## Quick start on the doc

See the [sphinx doc](https://www.sphinx-doc.org/en/master/usage/quickstart.html)
for more.

This
[blog post](https://medium.com/@richdayandnight/a-simple-tutorial-on-how-to-document-your-python-project-using-sphinx-and-rinohtype-177c22a15b5b)
is also useful.

```bash
cd docs
sphinx-quickstart # launch a basic interactive set up of sphinx
```

Answer the questions on prompt.

## Setting up conf.py for matlab doc

Following the documentation from
[matlabdomain for sphinx](https://github.com/sphinx-contrib/matlabdomain).

Specify the extensions you are using:

```python
extensions = [
    'sphinxcontrib.matlab',
    'sphinx.ext.autodoc']
```

`matlab_src_dir` in `docs/source/conf.py` should have the path (relative to `conf.py`)
to the folder containing your matlab code:

```python
matlab_src_dir = os.path.dirname(os.path.abspath('../../src'))
```

## reStructured text markup

reStructured text mark up
[primer](https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html).

## "Templates"

There are different ways you can document the help section of your matlab
functions so it can be documented automatically by sphinx.

```matlab
function y = my_function(arg1, arg2)
    %
    % Describe what the function does here.
    %
    %  y = my_function_napoleon(arg1, arg2)
    %
    % :param arg1: The first input value
    % :param arg2: The second input value
    % :returns: The input value multiplied by two

    y = arg1 + arg2
```

"Napoleon" way more similar to Numpy:

```matlab
function y = my_function_napoleon(arg1, arg2)
    %
    % Describe what the function does here.
    %
    %  y = my_function_napoleon(arg1, arg2)
    %
    % Parameters:
    %    x: The first input value
    %
    %    y: The second input value
    %
    % Returns:
    %    The input value multiplied by two

    y = x * 2;
```

You then just need to insert this in your `.rst` file for the documentation to
be done automatically.

```rst

.. automodule:: src .. <-- This is necessary for autodocumenting the rest

.. autofunction:: my_function

.. autofunction:: my_function_napoleon
```

## Build the documentation locally

From the `docs` directory:

```bash
sphinx-build -b html source build
```

This will build an html version of the doc in the `build` folder.

## Buid the documentation with Read the Docs

Add a [`.readthedocs.yml`](../.readthedocs.yml) file in the root of your repo.

See [HERE](https://docs.readthedocs.io/en/stable/config-file/v2.html) for
details.

You can then trigger the build of the doc by going to the [read the docs](https://readthedocs.org)
website.

You might need to be added as a maintainer of the doc.

The doc can be built from any branch of a repo.

<!-- TODO -->

## Other matlab projects that use

### Sphinx

Some are listed
[sphinx-contrib/matlabdomain#users](https://github.com/sphinx-contrib/matlabdomain#users)

### Read the docs

- [qMRLab](https://github.com/qMRLab/qMRLab/wiki/Guideline:-Generating-Documentation)
