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
        ├── singularity_ngen.def
        └── templates
            ├── guide
                └── HelloNGEN.sh

    ```
    1. [`guilde.sh`](guide.sh) : The guide script to run the simulations on the singularity image
    2. [`README.md`](README.md) : Documentation of how to run the model and contribute in development on NGIAB
    3. [`singularity_ngen.def`](singularity/singularity_ngen.def) : The singularity definition file to build image
    4. [`HelloNGEN.sh`](singularity/templates/guide/HelloNGEN.sh) : This is NGen execution script, which runs when the image is being executed by users.

## Prerequisites
### 1. Access a compute node
On your HPC system, request an interactive session on a compute node using your scheduler (e.g., SLURM):
```bash
srun --partition=<partition_name> --nodes=1 --ntasks=1 --time=<hh:mm:ss> --pty bash
```
Replace `<partition_name>` and `<hh:mm:ss>` with the appropriate partition and time limits for your HPC system.
### 2. Install SingularityCE on HPC
Ensure SingularityCE is installed and validated on your HPC system. All operations, including data preparation and running the simulation, should be performed on a compute node, not the login node. Consult your system administrator or follow these steps:

**i. Check Singularity Availability**: 

Verify that SingularityCE is installed on your HPC environment by running:
```bash
singularity --version
```
**ii. Install SingularityCE (if necessary)**: 

Refer to the [official SingularityCE installation guide](https://docs.sylabs.io/guides/4.0/admin-guide/installation.html#installation-on-linux) for instructions tailored to Linux environments.



### Input Data
- **Download Sample Data:** Use the provided commands to download sample data for the Sipsey Fork case study.
- **To generate your own data:** Refer to the [NGIAB-datapreprocessor](https://github.com/AlabamaWaterInstitute/NGIAB_data_preprocess) for instructions on generating custom input data.
- **To generate your own data and run using NGIAB:** Refer to the [ngen-datastream repository](https://github.com/CIROH-UA/ngen-datastream/tree/main) for instructions on generating custom input data.


This section guides you through downloading and preparing the sample input data for the NextGen In A Box project.

**Step 1: Create Project Directory**

On the HPC system, create a directory for the project and data using the following commands:
```bash
mkdir -p NextGen/ngen-data
```

```bash
cd NextGen/ngen-data
```

**Step 2: Download Sample Data**

Use wget to download the compressed data file:

**Option 1: AWI-007 input data (relization file includes - SLOTH, NoahOWP, CFE)**
```bash
wget --no-parent https://ciroh-ua-ngen-data.s3.us-east-2.amazonaws.com/AWI-007/AWI_16_2863657_007.tar.gz
```
**Option 2: AWI-008 input data (realization file includes - SLOTH, Demostration LSTM)**
```bash
wget --no-parent https://ciroh-ua-ngen-data.s3.us-east-2.amazonaws.com/AWI-008/AWI_16_2863806_008.tar.gz
```

**Step 3: Extract and Rename**

Extract the downloaded file and optionally rename the folder:

**Option 1:**
```bash
tar -xf AWI_16_2863657_007.tar.gz
```
**Option 2:**
```bash
tar -xf AWI_16_2863806_008.tar.gz
```

Now you have successfully downloaded and prepared the sample input data in the NextGen/ngen-data directory. 

**Step 4: Clone and Run**
Navigate to the NextGen directory, clone the repository, and execute the guide script:
```bash
cd ../../NextGen
```
```bash
git clone https://github.com/CIROH-UA/NGIAB-HPCInfra.git
```
```bash
cd NGIAB-HPCInfra
```
```bash
./guide.sh
```
**Step 5: Visualize results**
After the `.guide.sh` script completes execution, you will be prompted to view your results using the NGIAB visualizer

Note: If you only need to visualize existing outputs without re-running the analysis, you can execute viewOnTethys.sh directly.

```bash
sh viewOnTethys.sh
```

The visualization server runs on port `8080` of the HPC node. To access it from your local machine:

```bash
user@laptop ~ $ ssh -R 8080:localhost:8080 user@hpc_node
```

This instructs SSH to forward connections from port 8080 on the remote machine to port 8080 on “localhost” (which in the case of remote forwards refers to the local machine)

Access the visualizer by opening in your local browser: `http://localhost:8080`

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
