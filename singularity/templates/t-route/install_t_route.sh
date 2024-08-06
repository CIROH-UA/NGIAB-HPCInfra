#!/bin/bash

current_path=`pwd`

echo "==========================================================="
echo "-- Now loding modules ..."
echo "-----------------------------------------------------------"
source /etc/profile.d/modules.sh
module load mpi
module list

echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Cloning and Installing NOAA-OWP T-Route ..."
echo "-----------------------------------------------------------"
export FC=gfortran NETCDF=/usr/include
git clone --progress --single-branch --branch master https://github.com/NOAA-OWP/t-route
cd t-route
git submodule update --init

./compiler.sh no-e

cd /t-route/src/troute-network
python setup.py --use-cython bdist_wheel
cp /t-route/src/troute-network/dist/*.whl /t-route/wheels

cd /t-route/src/troute-routing
python setup.py --use-cython bdist_wheel
cp /t-route/src/troute-routing/dist/*.whl /t-route/wheels

# troute-config doesn't use setup.py, use build to make the wheel
cd /t-route/src/troute-config
python -m build . \
cp /t-route/src/troute-routing/dist/*.whl /t-route/wheels

cd /t-route/src/troute-nwm
python -m build . \
cp /t-route/src/troute-nwm/dist/*.whl /t-route/wheels

#cd /t-route
#cp /t-route/src/troute-network/dist/*.whl /t-route/wheels
#cp /t-route/src/troute-routing/dist/*.whl /t-route/wheels
#cp /t-route/src/troute-config/dist/*.whl /t-route/wheels
#cp /t-route/src/troute-nwm/dist/*.whl /t-route/wheels
