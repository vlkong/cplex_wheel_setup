# Building wheels from CPLEX

Assuming we have an unix like terminal and Cplex Optimization Studio is installed in `$CPLEX_STUDIO_DIR201`.
One can build an universal wheel for the CPLEX Python API with a few steps. The universal wheel can be installed
on any platform, any python version - but as CPLEX Python API is platform and python version dependent, make
sure you install the wheel in the same runtime environment.

First, you need to install a few python packages needed to build the wheels:

```
$ pip install setuptools wheel
```

Let's copy the CPLEX Python API source to somewhere we can write to, for example `$HOME/cplex_universal_wheel`.

Assuming python 3.7 and Linux (substitue with your actual python version and COS platform tag)
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
Now we can build the wheels:
```
$ cd $HOME/cplex_universal_wheel
$ python setup.py bdist_wheel
```

The resulting wheel is `$HOME/cplex_universal_wheel/dist/cplex-20.1.0.1-py3-none-any.whl` -
In this example, it is safe to `pip install cplex-20.1.0.1-py3-none-any.whl` on any python 3.7
and x86_64-Linux.

