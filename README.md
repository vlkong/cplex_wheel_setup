# Building wheels from CPLEX

Let's assume you're using an unix-like terminal and CPLEX Optimization Studio is installed in `$CPLEX_STUDIO_DIR201`.

You can build a universal wheel for the CPLEX Python API with a few shell commands.

The universal wheel can be installed
on any platform, any Python version - but as CPLEX Python API is platform and python version dependent, make
sure you install the wheel in the same runtime environment.

First, you need to install a few Python packages needed to build the wheel:

```
$ pip install setuptools wheel
```

Copy the CPLEX Python API source to somewhere you can write to, for example `$HOME/cplex_universal_wheel`.

Assuming Python 3.7 and Linux (substitue with your actual Python version and COS platform tag)
```
$ cp -r $CPLEX_STUDIO_DIR201/cplex/python/3.7/x86_64-Linux $HOME/cplex_universal_wheel
```

Edit file `$HOME/cplex_universal_wheel/setup.py`, and add an import of `setuptools`:
```
[...]
import platform

# add this line:
import setuptools

from distutils.core import setup
[...]
```
Now you can build the wheel:
```
$ cd $HOME/cplex_universal_wheel
$ python setup.py bdist_wheel
```

The resulting wheel is `$HOME/cplex_universal_wheel/dist/cplex-20.1.0.1-py3-none-any.whl` -
In this example, it is safe to `pip install cplex-20.1.0.1-py3-none-any.whl` on any Python 3.7
and x86_64-Linux.

