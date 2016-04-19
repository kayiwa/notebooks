#!/bin/bash

/opt/conda/bin/conda env create --name docnow-notebooks --file /tmp/environment.yml

source /opt/conda/bin/activate docnow-notebooks

jupyter notebook
