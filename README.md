# BOLT LMM GWAS Pipeline


## Table of Contents


[Setting up the compute environment](#setting_up_compute)


\
<a name=setting_up_compute />
## Setting up the compute environment

To build the python environment for running the snakemake pipeline, load `python 3.8.10` or compatible equivalent, then create the virtual environment and install pip dependencies.
```
# load base python3
module load gcc/9.4.0   # only relavent for use on Gardner
module load python/3.8.10   # only relavent for use on Gardner

# create the virtual environment
python3 -m venv env/snakemake/

# activate the virtual envirionment and install package dependencies
source env/snakemake/bin/activate
python3 -m pip install -r env/snakemake/requirements.txt

```





