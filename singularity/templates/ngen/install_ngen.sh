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
echo "-- Now Cloning NOAA-OWP ..."
echo "-----------------------------------------------------------"
if [ -d "/ngen" ];
then
	echo "Removing old NGen"
	echo "-----------------------------------------------------------"
	rm -rf /ngen
fi
git clone https://github.com/NOAA-OWP/ngen.git
cd ngen
echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Cloning GoogleTest, Pybind11 & External Libraries..."
echo "-----------------------------------------------------------"
git submodule update --init --recursive -- test/googletest
git submodule update --init --recursive -- extern/pybind11
git submodule update --init --recursive --depth 1
#cd extern/pybind11
#git checkout v2.6.0
echo "==========================================================="
echo "==========================================================="

/tmp/extern/install_extern_libraries.sh

echo ""
echo "==========================================================="
echo "-- Now Building NGen at /ngen/serialbuild ..."
echo "-----------------------------------------------------------"
cd /ngen
# cmake -B /ngen/mpibuild -S . -DNGEN_WITH_MPI=ON -DNGEN_WITH_PYTHON=ON -DNGEN_WITH_ROUTING=ON -DNGEN_WITH_NETCDF=ON -DNGEN_QUIET=ON
cmake -B $current_path/ngen/serialbuild -S . -DNGEN_WITH_MPI=OFF -DNGEN_WITH_PYTHON=ON -DNGEN_WITH_ROUTING=ON -DNGEN_WITH_NETCDF=ON -DNGEN_WITH_BMI_FORTRAN=ON -DNGEN_WITH_BMI_C=ON -DNGEN_QUIET=ON -DNETCDF_CXX_INCLUDE_DIR=/usr/local/include -DNETCDF_CXX_LIBRARY=/usr/local/lib64/libnetcdf-cxx4.so # -DNETCDF_INCLUDE_DIR=/usr/include -DNETCDF_LIBRARY=/usr/lib64/libnetcdf.so
echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Installing Serialize NGen ..."
echo "-----------------------------------------------------------"
cd /ngen/serialbuild
cmake --build . -j $(nproc) --target ngen
echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Building NGen at /ngen/parallelbuild ..."
echo "-----------------------------------------------------------"
cd /ngen
# cmake -B /ngen/mpibuild -S . -DNGEN_WITH_MPI=ON -DNGEN_WITH_PYTHON=ON -DNGEN_WITH_ROUTING=ON -DNGEN_WITH_NETCDF=ON -DNGEN_QUIET=ON
cmake -B $current_path/ngen/parallelbuild -S . -DNGEN_WITH_MPI=ON -DNGEN_WITH_PYTHON=ON -DNGEN_WITH_ROUTING=ON -DNGEN_WITH_NETCDF=ON -DNGEN_WITH_BMI_FORTRAN=ON -DNGEN_WITH_BMI_C=ON -DNGEN_QUIET=ON -DNETCDF_CXX_INCLUDE_DIR=/usr/local/include -DNETCDF_CXX_LIBRARY=/usr/local/lib64/libnetcdf-cxx4.so # -DNETCDF_INCLUDE_DIR=/usr/include -DNETCDF_LIBRARY=/usr/lib64/libnetcdf.so
echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Installing NGen ..."
echo "-----------------------------------------------------------"
cd /ngen/parallelbuild
cmake --build . -j $(nproc) --target ngen
echo "==========================================================="
echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Building partitionGenerator (in build directory)"
echo "-----------------------------------------------------------"
make partitionGenerator
echo "==========================================================="
echo "==========================================================="

# echo ""
# echo "==========================================================="
# echo "-- Now Generating partition config (in data directory)"
# echo "-----------------------------------------------------------"
# cd /ngen/data
# /ngen/mpibuild/partitionGenerator catchment_data.geojson nexus_data.geojson partition_config.json 3 '' ''
# echo "==========================================================="
# echo "==========================================================="

echo ""
echo "==========================================================="
echo "-- Now Creating symbolink link ..."
echo "-----------------------------------------------------------"
ln -s /ngen/serialbuild/ngen /dmod/bin/ngen-serial
ln -s /ngen/parallelbuild/ngen /dmod/bin/ngen-parallel
ln -s /ngen/parallelbuild/partitionGenerator /dmod/bin/partitionGenerator
# ln -s awi_simplified_realization.json realization_config.json
echo "==========================================================="
echo "==========================================================="