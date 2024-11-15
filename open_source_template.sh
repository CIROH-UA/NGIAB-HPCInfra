#!/bin/bash

# Clone the CIROH open source project template repository
git clone https://github.com/CIROH-UA/CIROH-open-source-project-template.git

# Move template files to the root directory of your project
mv CIROH-open-source-project-template/* .

# Remove the cloned repository directory
rm -rf CIROH-open-source-project-template
rm -rf open_source_template.sh

echo "CIROH open source project template files have been installed."
