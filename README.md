# **NextGen In A Box (NGIAB)**

**Run the NextGen National Water Resources Modeling Framework locally with ease.**

NGIAB provides a containerized and user-friendly solution for running the NextGen framework, allowing you to control inputs, configurations, and execution on your local machine.

<p align="center">
<img src="https://github.com/CIROH-UA/NGIAB-CloudInfra/blob/main/image/README/ngiab.png" width="300">
</p>

| | |
| --- | --- |
| ![alt text](https://ciroh.ua.edu/wp-content/uploads/2022/08/CIROHLogo_200x200.png) | Funding for this project was provided by the National Oceanic & Atmospheric Administration (NOAA), awarded to the Cooperative Institute for Research to Operations in Hydrology (CIROH) through the NOAA Cooperative Agreement with The University of Alabama (NA22NWS4320003). |

<!-- [![ARM Build and push final image](https://github.com/CIROH-UA/NGIAB-CloudInfra/actions/workflows/docker_image_main_branch.yml/badge.svg)](https://github.com/CIROH-UA/NGIAB-CloudInfra/actions/workflows/docker_image_main_branch.yml)
[![X86 Build and push final image](https://github.com/CIROH-UA/NGIAB-CloudInfra/actions/workflows/docker_image_main_x86.yml/badge.svg)](https://github.com/CIROH-UA/NGIAB-CloudInfra/actions/workflows/docker_image_main_x86.yml) -->

**Why NextGen In A Box?**

- **Run NextGen Locally:** Experiment with the framework and customize configurations on your local machine.
- **Control Over Inputs:** Choose specific regions or basins for analysis and modify input data as needed.
- **Simplified Setup:** Utilize Docker containers for effortless deployment, avoiding complex software installations.
- **Open Research Practices:** Promote transparency and reproducibility through open-source tools like Git and GitHub.


<!-- ## Table of Contents
* [Repository Information](#repository-information)
* [Prerequisites](#prerequisites)
    + [Install Singularity](#install-sigularityce-and-validate-sigularityce-is-up)
    + [Install WSL on Windows](#install-wsl-on-windows)
* [Run NextGen-In-A-Box](#run-nextgen-in-a-box)
    + [Clone Ngen-Singularity repository](#clone-ngen-singularity-repository)
    + [How to run the model script?](#how-to-run-the-model-script)
    + [Output of the model script](#output-of-the-model-guide-script) -->

## Repository Information
- This branch specifically for the users of Singularity container image to run simulation on NextGen Framework
- The file structure and brife information of each file:
    ```bash 
    .
    ├── guide.sh
    ├── README.md
    └── singularity
        ├── build.log
        ├── singularity_ngen.def
        └── templates
            ├── extern
            │   └── install_extern_libraries.sh
            ├── guide
            │   └── HelloNGEN.sh
            ├── netcdf
            │   └── install_netcdf_cxx.sh
            ├── ngen
            │   └── install_ngen.sh
            └── t-route
                └── install_t_route.sh
    ```
    1. [`guilde.sh`](guide.sh) : The guide script to run the simulations on the singularity image
    2. [`README.md`](README.md) : Documentation of how to run the model and contribute in development on NGIAB
    3. [`singularity_ngen.def`](singularity/singularity_ngen.def) : The singularity definition file to build image
    4. [`build.log`](singularity/build.log) : This is the last build log that shows all detailed information about the last image build process.
    5. [`install_extern_libraries.sh`](singularity/templates/extern/install_extern_libraries.sh) : This is helper script to install external NGen module during image building process.
    6. [`HelloNGEN.sh`](singularity/templates/guide/HelloNGEN.sh) : This is NGen execution script, which runs when the image is being executed by users.
    7. [`install_netcdf_cxx.sh`](singularity/templates/netcdf/install_netcdf_cxx.sh) : This is helper script to install latest NetCDF C++ version during image building process.
    8. [`install_ngen.sh`](singularity/templates/ngen/install_ngen.sh) : This is helper script to install latest NextGen version during image building process.
    9. [`install_t_route.sh`](singularity/templates/t-route/install_t_route.sh) : This is helper script to install latest T-route version during image building process. 

## Prerequisites

### Install SigularityCE and validate SigularityCE is up
<details>

<summary> On Windows </summary>

* To install SingularityCE on Windows, first you will need to install [WSL](#install-wsl-on-windows) 
* [Install SingularityCE Desktop on Windows](https://docs.sylabs.io/guides/4.0/admin-guide/installation.html#windows)
* Once SingularityCE is installed, the singularity command will now be available in your WSL2 environment.
* Type `singularity exec library://ubuntu echo "Hello World!"` to make sure singularity is working.

</details>

<details>

<summary> On Mac </summary>

- To install SingularityCE on Mac, the Sylabs recommend to use `Lima`, a Linux virtual machine with automatic file sharing and port forwarding (similar to WSL2).
- [Install SingularityCE on Mac](https://docs.sylabs.io/guides/4.0/admin-guide/installation.html#mac) 
- Once Lima is installed, start Lima virtual machine by downloading `AlmaLinux 9` based [template](https://raw.githubusercontent.com/sylabs/singularity/main/examples/lima/singularity-ce.yml).
    ```bash
        limactl start ./singularity-ce.yml
    ```
- Type `limactl shell singularity-ce` to start Lima VM with SingularityCE. Here you should be able to access Shell within Lima VM.
- Type `singularity --version` to make sure singularity is working.
</details>

<details>

<summary> On Linux </summary>

> [!NOTE]
> Please make sure you **install all the prerequisites** of installing SingularityCE on Linux.
- [Install docker on Linux](https://docs.sylabs.io/guides/4.0/admin-guide/installation.html#installation-on-linux)

</details>

### Install WSL on Windows

1. Follow Microsofts latest [instructions](https://learn.microsoft.com/en-us/windows/wsl/install) to install WSL
2. Once this is complete, follow the instructions for linux inside your wsl terminal.


### Input Data
- **Download Sample Data:** Use the provided commands to download sample data for the Sipsey Fork case study.
- **To generate your own data:** Refer to the [NGIAB-datapreprocessor](https://github.com/AlabamaWaterInstitute/NGIAB_data_preprocess) for instructions on generating custom input data.
- **To generate your own data and run using NGIAB:** Refer to the [ngen-datastream repository](https://github.com/CIROH-UA/ngen-datastream/tree/main) for instructions on generating custom input data.


This section guides you through downloading and preparing the sample input data for the NextGen In A Box project.

**Step 1: Create Project Directory**

- **Linux/Mac:** Open your terminal and go to your desired folder where you want to checkout repo and ngen-data folder and run the following commands:
```bash
mkdir -p NextGen/ngen-data
```

```bash
cd NextGen/ngen-data
```
- **WSL (Right click and run as Admin):** Open WSL with administrator privileges and execute:
```bash
cd /mnt/c/Users/<Folder>
```

```bash
mkdir -p NextGen/ngen-data
```

```bash
cd NextGen/ngen-data
```
**Step 2: Download Sample Data**

- **Linux/Mac/Windows WSL:** Use wget to download the compressed data file:
```bash
wget --no-parent https://ciroh-ua-ngen-data.s3.us-east-2.amazonaws.com/AWI-006/AWI_16_2853886_006.tar.gz
```

**Step 3: Extract and Rename**

- **All Platforms:** Extract the downloaded file and optionally rename the folder:
```bash
tar -xf AWI_16_2853886_006.tar.gz
```
### Below is Optional: Rename the folder
```bash
mv AWI_16_2853886_006 my_data
```
Now you have successfully downloaded and prepared the sample input data in the NextGen/ngen-data directory. Remember to replace "my_data" with your preferred folder name if you choose to rename it.

## Run NextGen In A Box
To run NextGen framework, hydrologist only have to execute the [guide script](https://github.com/CIROH-UA/Ngen-Singularity/blob/main/guide.sh) to run simulations on self-contained NextGen framework container image.
* The guide script feature:
    * Determine architecher of the underling system (ARM or x86)
    * Automaticlly download latest Singularity NextGen image from Docker Hub
    * Allow to attach input data by providing relative path of it
    * The options of running image:
        1. Run simulation in **Serial** mode 
        1. Run simulation in **Parallel** mode
        1. Run image in **Interactive shell** mode


<!-- ### Clone Ngen-Singularity repository

Navigate to NextGen directory and clone the repository using below commands:

```bash
    git clone https://github.com/CIROH-UA/Ngen-Singularity.git
    cd Ngen-Singularity
    git checkout main
``` 
Once you are in *Ngen-Singularity* directory and on `main` branch, you should see [`guide.sh`](#how-to-run-the-model-script) in it. Now, we are ready to run the model using that script. 

### How to run the model script?

#### WSL, Linux and Mac Steps:
Follow below steps to run `guide.sh` script 

```bash
    ./guide.sh    
```
- The script prompts the user to enter the file path for the input data directory where the forcing and config files are stored. 

Run the following command and copy the path value:  
```bash
    # navigate to the data folder you created earlier
    cd NextGen/ngen-data/AWI_03W_113060_002 # or NextGen/ngen-data/my_data if you renamed it
    pwd
    # and copy the path
```
where <path> is the location of the folder with your data in it.
    
- The script sets the entered directory as the `HOST_DATA_PATH` variable and uses it to find all the catchment, nexus, and realization files using the `find` command.
- Next, the user is asked whether to run NextGen or exit. If `run_NextGen` is selected, the script pulls the related image from the awiciroh DockerHub, based on the local machine's architecture:
```
For Mac with apple silicon (arm architecture), it pulls XXXXX
For x86 machines, it pulls library://trupeshkumarpatel/awiciroh/ciroh-ngen-singularity:latest.
```

- The user is then prompted to select whether they want to run the model in parallel or serial mode.
- If the user selects parallel mode, the script uses the `mpirun` command to run the model and generates a partition file for the NGEN model.
- If the user selects the catchment, nexus, and realization files they want to use.

Example NGEN run command for parallel mode: 
```bash
/dmod/bin/partitionGenerator "/ngen/ngen/data/config/catchments.geojson" "/ngen/ngen/data/config/nexus.geojson" "partitions_2.json" "2" '' ''
mpirun -n 2 /dmod/bin/ngen-parallel \
/ngen/ngen/data/config/catchments.geojson "" \
/ngen/ngen/data/config/nexus.geojson "" \
/ngen/ngen/data/config/awi_simplified_realization.json \
/ngen/partitions_2.json
```
- If the user selects serial mode, the script runs the model directly.

Example NGEN run command for serial mode: 
```bash
/dmod/bin/ngen-serial \
/ngen/ngen/data/config/catchments.geojson "" \
/ngen/ngen/data/config/nexus.geojson "" \
/ngen/ngen/data/config/awi_simplified_realization.json
```
- After the model has finished running, the script prompts the user whether they want to continue.
- If the user selects 1, the script opens an interactive shell.
- If the user selects 2, then the script exits.

### Output of the model guide script

The output files are copied to the `outputs` folder in the 'NextGen/ngen-data/AWI_03W_113060_002/' directory you created in the first step
 -->
