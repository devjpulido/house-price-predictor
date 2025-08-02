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
# http://localhost:5555/
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
# URL: http://170.64.197.222:8888/lab?token=0d84c52bb3c60c2a12c0eeb1cb2c9a4eb02b420cb2ffafwew
################################################
uv pip install jupyterlab
uv python -m jupyterlab
python -m jupyterlab
python -m jupyterlab --allow-root # Run as root

python -m jupyterlab --ip=0.0.0.0 --port=8888 --no-browser --allow-root

sudo ufw allow 8888



###############################################
# Model Workflow
# Step 1: Data Processing
# Clean and preprocess the raw housing dataset
#################################################
python src/data/run_processing.py   --input data/raw/house_data.csv   --output data/processed/cleaned_house_data.csv


###############################################
# Step 2: Feature Engineering
# Apply transformations and generate features
#################################################
python src/features/engineer.py   --input data/processed/cleaned_house_data.csv   --output data/processed/featured_house_data.csv   --preprocessor models/trained/preprocessor.pkl


###############################################
# Step 3: Modeling & Experimentation
# Train your model and log everything to MLflow
#################################################
python src/models/train_model.py   --config configs/model_config.yaml   --data data/processed/featured_house_data.csv   --models-dir models   --mlflow-tracking-uri http://localhost:5555


###############################################
# Step 4: Build the Docker image for the API
# within the root of the repository
#################################################
touch Dockerfile

docker image build -t fastapi .
docker image ls
docker image history fastapi
docker run -idtP fastapi
docker ps -l
docker run --rm -it fastapi bash
docker rm -f 3928e888c4de


docker image build -t neojpulido/streamlit:v1 .
docker run -idtP neojpulido/streamlit:v1

docker image push neojpulido/streamlit:v1

cd streamlit_app
docker image build -t neojpulido/streamlit:dev .

cd /home/sysadm/house-price-predictor
docker image build -t neojpulido/fastapi:dev .

docker image push neojpulido/streamlit:dev
docker image push neojpulido/fastapi:dev

docker compose up -d
docker compose ps
docker compose stop
docker compose start
docker compose down