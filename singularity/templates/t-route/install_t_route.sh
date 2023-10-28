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
git clone --progress --single-branch --branch master http://github.com/TrupeshKumarPatel/t-route.git
cd t-route
# cp /tmp/t-route/compiler.sh .

./compiler.sh no-e

cd /t-route/src/troute-network
python setup.py --use-cython bdist_wheel

cd /t-route/src/troute-routing
python setup.py --use-cython bdist_wheel

cd /t-route/src/troute-nwm
python setup.py bdist_wheel

cd /t-route
cp /t-route/src/troute-network/dist/*.whl /t-route/wheels
cp /t-route/src/troute-routing/dist/*.whl /t-route/wheels
cp /t-route/src/troute-nwm/dist/*.whl /t-route/wheels