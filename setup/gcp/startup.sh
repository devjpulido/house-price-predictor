#!/bin/bash

apt-get update
apt-get install -y python3-pip git curl unzip

pip3 install --upgrade pip
pip3 install jupyterlab pandas numpy scikit-learn matplotlib seaborn

# Optional: Install Docker if needed
# apt-get install -y docker.io

# Start JupyterLab (no password, token access)
nohup jupyter lab --ip=0.0.0.0 --no-browser --allow-root &

echo "Setup complete."