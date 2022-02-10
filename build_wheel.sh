#!/bin/bash -e -x

CPLEX_DIR=$CPLEX_STUDIO_DIR221
PYTHON_VERSION=3.8
PLATFORM=x86-64_osx

if [ -d build ]; then
	echo "'build' directory already exists. Exiting..."
	exit 1
fi
if [ -d build_wheel_venv ]; then
	echo "'build_wheel_venv' directory already exists. Exiting..."
	exit 1
fi

python -m venv build_wheel_venv
source build_wheel_venv/bin/activate
pip install --upgrade pip
pip install setuptools wheel

mkdir build
cd build

cp -r $CPLEX_DIR/cplex/python/$PYTHON_VERSION/$PLATFORM cplex
cd cplex
sed -i .bak '1s/^/import setuptools\n/' setup.py
python setup.py bdist_wheel
cd ..

cp -r $CPLEX_DIR/python/docplex .
cd docplex
sed -i .bak '1s/^/import setuptools\n/' setup.py
python setup.py bdist_wheel
cd ..

cd ..
mv build/cplex/dist/*.whl build/docplex/dist/*.whl .


# Rename the wheels so that they have a name that really
# fits their content
PYTHON_VERSION_NO_DOT=${PYTHON_VERSION//./}
PYTHON_PLATFORM=`python -c "import distutils.util
print(distutils.util.get_platform())"`
PYTHON_PLATFORM=${PYTHON_PLATFORM//./_}
PYTHON_PLATFORM=${PYTHON_PLATFORM//-/_}
for f in *.whl; do
	mv $f `echo $f | sed "s/-py3-/-py$PYTHON_VERSION_NO_DOT-/"`
done
for f in *.whl; do
	mv $f `echo $f | sed "s/any/$PYTHON_PLATFORM/"`
done

# Clean after ourselves...
rm -rf build_wheel_venv
rm -rf build
