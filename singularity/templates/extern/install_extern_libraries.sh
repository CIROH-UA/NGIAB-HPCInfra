#!/bin/bash

echo "==========================================================="
echo "-- Now loding modules ..."
echo "-----------------------------------------------------------"
source /etc/profile.d/modules.sh
module load mpi
module list

echo "==========================================================="
echo "==========================================================="

# echo ""
# echo "==========================================================="
# echo "-- Now Installing External Library t-route ..."
# echo "-----------------------------------------------------------"
# cd /ngen/extern/t-route
# git checkout master
# git pull origin master
# cp /tmp/t-route/compiler.sh .
# chmod 777 compiler.sh && chmod +x compiler.sh
# ./compiler.sh no-e
# 
# echo "==========================================================="
# echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Installing External Library iso_c_fortran_bmi ..."
echo "-----------------------------------------------------------"
cd /ngen/extern/iso_c_fortran_bmi
cmake -B cmake_build -S .
cmake --build cmake_build --target iso_c_bmi -- -j 2

echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Installing External Library noah-owp-modular ..."
echo "-----------------------------------------------------------"
cd /ngen/extern/noah-owp-modular
# cmake -B cmake_build -S .
cmake -DnetCDF_MOD_PATH=/usr/include/openmpi-x86_64/ -B cmake_build -S .
cmake --build cmake_build --target surfacebmi -- -j 2

echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Installing External Library cfe ..."
echo "-----------------------------------------------------------"
cd /ngen/extern/cfe
cmake -B cmake_build -S .
cmake --build cmake_build --target cfebmi -- -j 2

echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Installing External Library evapotranspiration ..."
echo "-----------------------------------------------------------"
cd /ngen/extern/evapotranspiration/evapotranspiration
cmake -B cmake_build -S .
cmake --build cmake_build --target petbmi -- -j 2

echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Installing External Library topmodel ..."
echo "-----------------------------------------------------------"
cd /ngen/extern/topmodel
cmake -B cmake_build -S .
cmake --build cmake_build --target topmodelbmi -- -j 2

echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Installing External Library sloth ..."
echo "-----------------------------------------------------------"
cd /ngen/extern/sloth
cmake -B cmake_build -S .
cmake --build cmake_build --target all

echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Setting Shared Library"
echo "-----------------------------------------------------------"
cd /
mkdir -p dmod/shared_libs && mkdir -p dmod/bin && mkdir -p /dmod/datasets && mkdir -p /dmod/datasets/static
chown -R root dmod
find /ngen/extern/ -name "*.so*" -exec ln -s "{}" /dmod/shared_libs/ \;

ls -ahl /dmod/shared_libs
echo "==========================================================="
echo "==========================================================="