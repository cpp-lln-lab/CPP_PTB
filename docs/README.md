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
