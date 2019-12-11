#!/bin/bash

while getopts ":e:p:r:h:" opt; do
  case $opt in
    e) env_name="$OPTARG"
    ;;
    p) pversion="$OPTARG"
    ;;
    r) requirements_file="$OPTARG"
    ;;
    h)
      echo "Usage:"
      echo "    ./setup_python_environment -e ml -p 3 -r requirements.txt"
      exit 0
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done


conda create -y -n $env_name python=$pversion
CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh
conda config --add channels conda-forge
conda config --add channels bioconda
conda activate $env_name
while read requirement; do
    conda install --yes $requirement || pip install $requirement; done < $requirements_file
conda env export > $env_name".yml"


