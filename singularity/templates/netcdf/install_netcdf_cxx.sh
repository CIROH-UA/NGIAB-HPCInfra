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
echo "I AM AT: " $current_path
echo "==========================================================="
cd /tmp/netcdf

curl -s https://api.github.com/repos/Unidata/netcdf-cxx4/releases/latest | grep "tarball_url" | cut -d '"' -f 4 | xargs curl -L -o netcdf-cxx4-latest.tar.gz ;
mkdir netcdf-cxx4-latest
tar -xvzf netcdf-cxx4-latest.tar.gz -C netcdf-cxx4-latest --strip 1
mkdir -p netcdf-cxx4-latest/build && cd netcdf-cxx4-latest/build
../configure --enable-parallel --prefix=/usr
cmake ..
make -j$(nproc) install
