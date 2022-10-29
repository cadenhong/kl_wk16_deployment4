#!/bin/bash

sudo apt update
sudo apt -y install git python3-pip

git clone https://github.com/kura-labs-org/kuralabs_deployment_3.git
cd kuralabs_deployment_3/

pip install -r requirements.txt
pip install gunicorn

python3 -m gunicorn -w 4 application:app -b 0.0.0.0 --daemon