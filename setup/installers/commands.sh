###############################################
# Git clone the repository
###############################################
export GITHUB_ACCOUNT=devjpulido
git clone https://github.com/$GITHUB_ACCOUNT/house-price-predictor.git -b develop
cd house-price-predictor

# Configure Git user details
git config --local user.name "Juan Pulido"
git config --local user.email "jpul0007@student.monash.edu"


###############################################
# Install Docker
###############################################
bash ./setup/installers/docker.sh


###############################################
# Install Mlflow via Docker Image
# http://170.64.197.222:5555/
###############################################
cd deployment/mlflow
docker compose -f docker-compose.yaml up -d

    
###############################################
# Setup Python Virtual Environment using UV:
###############################################
curl -Ls https://astral.sh/uv/install.sh | bash
source $HOME/.local/bin/env

uv venv --python python3.11
source .venv/bin/activate

#Install dependencies: 
uv pip install -r requirements.txt


################################################
# Start JupyterLab
################################################
uv pip install jupyterlab
uv python -m jupyterlab
python -m jupyterlab
python -m jupyterlab --allow-root # Run as root

python -m jupyterlab --ip=0.0.0.0 --port=8888 --no-browser --allow-root

sudo ufw allow 8888

http://170.64.197.222:8888/lab?token=0d84c52bb3c60c2a12c0eeb1cb2c9a4eb02b420cb2ffaf38