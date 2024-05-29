#!/bin/bash

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
cmake -DNETCDF_MODULE_DIR=/usr/lib64/gfortran/modules/openmpi/ -B cmake_build -S .
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
cp /tmp/guide/HelloNGEN.sh /ngen/HelloNGEN.sh 
chown -R root /dmod /ngen /root
chmod a+x /dmod/bin/* /ngen/HelloNGEN.sh /root
find /ngen/extern/ -name "*.so*" -exec ln -s "{}" /dmod/shared_libs/ \;
find /ngen/extern/noah-owp-modular -type f -iname "*.TBL" -exec cp '{}' /dmod/datasets/static  \; 
ls -ahl /dmod/shared_libs
echo "==========================================================="
ls -ahl /dmod/datasets/static
echo "==========================================================="
echo "==========================================================="