

##################

export GITHUB_ACCOUNT=devjpulido

git clone https://github.com/$GITHUB_ACCOUNT/house-price-predictor.git -b develop
cd house-price-predictor
bash ./setup/installers/setup.sh

git config --local user.name "Juan Pulido"
git config --local user.email "jpul0007@student.monash.edu"