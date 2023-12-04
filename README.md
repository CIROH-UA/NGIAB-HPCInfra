# Welcome to NextGen Framework National Water Model Community Repo. (NextGen In A Box).

We are doing a case study : NWM run for Sipsey Fork, Black Warrior river
- We don’t want to run all of CONUS
- We want to run NextGen locally
- We want to have control over inputs / config.
- How can we do it? Answer: NextGen In A Box

## Table of Contents
* [About](#about)
* [Development](#development)
* [Prerequisites](#prerequisites)
    + [Install Singularity](#install-sigularityce-and-validate-sigularityce-is-up)
    + [Install WSL on Windows](#install-wsl-on-windows)
    + [Download the input data in "ngen-data" folder from S3 bucket ](#download-the-input-data-in-ngen-data-folder-from-s3-bucket)
* [Run NextGen-In-A-Box](#run-nextgen-in-a-box)
    + [Clone Ngen-Singularity repo](#clone-ngen-singularity-repository)
    + [How to run the model script?](#how-to-run-the-model-script)
    + [Output of the model script](#output-of-the-model-guide-script)

## About
The NextGen water modeling framework incorporates an encapsulation strategy that prioritizes hydrological data as its foundational element, subsequently constructing a functional abstraction of hydrological behavior. This abstraction exhibits inherent recursion, thereby facilitating an elevated level of modeling and reasoning through the application of computational modeling within the domain of hydrology.
* To run NextGen framework, hydrologist only have to execute the [guide script](https://github.com/CIROH-UA/Ngen-Singularity/blob/main/guide.sh) to run simulations on self-contained NextGen framework container image.
* The guide script feature:
    * Determine architecher of the underling system (ARM or x86)
    * Automaticlly download latest Singularity NextGen image from Docker Hub
    * Allow to attach input data by providing relative path of it
    * The options of running image:
        1. Run simulation in **Serial** mode 
        1. Run simulation in **Parallel** mode
        1. Run image in **Interactive shell** mode

## Development
- This branch ([`develop`](https://github.com/CIROH-UA/Ngen-Singularity/tree/develop)) specifically use to develop Singularity Definition to create container image for NextGen Framework
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
- On *Windows*:
    - To install SingularityCE on Windows, first you will need to install [WSL](#install-wsl-on-windows) 
    - [Install SingularityCE Desktop on Windows](https://docs.sylabs.io/guides/4.0/admin-guide/installation.html#windows)
    - Once SingularityCE is installed, the singularity command will now be available in your WSL2 environment.
    - Type `singularity exec library://ubuntu echo "Hello World!"` to make sure singularity is working.
    
- On *Mac*:
    - To install SingularityCE on Mac, the Sylabs recommend to use `Lima`, a Linux virtual machine with automatic file sharing and port forwarding (similar to WSL2).
    <!-- - Install Lima:
        - Install Homebrew (You can skip this step if you already have Homebrew installed on you Mac)
        - Open terminal and run following command:
            ```bash
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            ```
        - Now, run following command to install Lima
            ```bash
            brew install lima
            ``` -->
    - [Install SingularityCE on Mac](https://docs.sylabs.io/guides/4.0/admin-guide/installation.html#mac) 
    - Once Lima is installed, start Lima virtual machine by downloading `AlmaLinux 9` based [template](https://raw.githubusercontent.com/sylabs/singularity/main/examples/lima/singularity-ce.yml).
        ```bash
        limactl start ./singularity-ce.yml
        ```
    - Type `limactl shell singularity-ce` to start Lima VM with SingularityCE. Here you should be able to access Shell within Lima VM.
    - Type `singularity --version` to make sure singularity is working.
        
- On *Linux*:
    > [!NOTE]
    > Please make sure you **install all the prerequisites** of installing SingularityCE on Linux.
    - [Install docker on Linux](https://docs.sylabs.io/guides/4.0/admin-guide/installation.html#installation-on-linux)



### Install WSL on Windows

1. Follow Microsofts latest [instructions](https://learn.microsoft.com/en-us/windows/wsl/install) to install wsl  
2. Once this is complete, follow the instructions for linux inside your wsl terminal.

    
### Download the input data in "ngen-data" folder from S3 bucket

#### Linux & Mac & WSL

```bash   
    mkdir -p NextGen/ngen-data
    cd NextGen/ngen-data
    wget --no-parent https://ciroh-ua-ngen-data.s3.us-east-2.amazonaws.com/AWI-002/AWI_03W_113060_002.tar.gz
    tar -xf AWI_03W_113060_002.tar.gz
    # to rename your folder
    mv AWI_03W_113060_002 my_data
```

## Run NextGen In A Box

### Clone Ngen-Singularity repository

Navigate to NextGen directory and clone the repository using below commands:

```bash
    git clone https://github.com/CIROH-UA/Ngen-Singularity.git
    cd Ngen-Singularity
    git checkout develop
```  
Once you are in *Ngen-Singularity* directory and on `develop` branch, you can choose to:
- **Run** the latest image from the Docker Hub
    - All you need to do is to [execute `guide.sh`](#how-to-run-the-model-script) file, and provide absolute path of [the data](#download-the-input-data-in-ngen-data-folder-from-s3-bucket)
- **Develop** and contribute to Ngen-Singularity repository for future enhacement of this project
    - Please follow the [file structure](#development) and naming conventions to contribute.

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
For Mac with apple silicon (arm architecture), it pulls awiciroh/ciroh-ngen-image:latest.
For x86 machines, it pulls awiciroh/ciroh-ngen-image:latest-x86.
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

