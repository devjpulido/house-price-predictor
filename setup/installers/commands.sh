

##################

export GITHUB_ACCOUNT={your_github_account}
git clone https://github.com/$GITHUB_ACCOUNT/devops-capstone-project.git
cd devops-capstone-project
bash ./bin/setup.sh

git config --local user.name "{your GitHub name here}"
git config --local user.email {your GitHub email here}