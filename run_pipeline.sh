#!/bin/bash
#PBS -N BOLT-LMM-GWAS-pipeline
#PBS -S /bin/bash
#PBS -l walltime=08:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=2gb
#PBS -o logs/BOLT-LMM-GWAS_pipeline.out
#PBS -e logs/BOLT-LMM-GWAS-pipeline.err

# File Name: Pipeline_Submit_gardnerCRI.sh
# Created On: 2022-07-07
# Created By: ZW
# Purpose: runs the BOLT-LMM GWAS pipeline for given genotypes and phenotypes

# check passed commandline arguments
## of which there are two.
###   -j (Number of concurrent jobs) [required]
###   -c <analysis configuration file .yaml> [required]
###   -d (BOOLEAN flag to complete a snakemake dry run) [optional]

while getopts ":j:c:d" 'opt';
do
    case ${opt} in
        j) 
            parallel_jobs=${OPTARG}
            ;;  # capture command line argument for number of possible concurrent jobs
        c) 
            config_file=${OPTARG}
            ;;  # capture command line argument for YAML config file
        d) 
            dry_run_flag="--dry-run"
            ;;  # capture boolean for whether or not its a 'dry run'
        *)
            echo "INVALID_OPTION -- ${OPTARG}"
            exit 1
            ;;  # capture all other (invalid) inputs
    esac
done


# print the passed commandline options
echo "Number of concurrent jobs: ${parallel_jobs}"
echo "Selected config file: ${config_file}"
echo "dry run ?: ${dry_run_flag}"

# run the snakemake workflow
snakemake --snakefile Snakefile \
    -j ${parallel_jobs} -kp --rerun-incomplete \
    --config cfg_file=${config_file} \
    --cluster "qsub -V -l walltime={resources.walltime} \
     -l nodes={resources.nodes}:ppn={resources.processors_per_node} \
     -l mem={resources.total_memory}mb \
     -N {rulename}_{resources.job_id} \
     -S /bin/bash \
     -e logs/{rulename}_{resources.job_id}.err \
     -o logs/{rulename}_{resources.job_id}.out" \
     ${dry_run_flag} 1>  "logs/BOLT-LMM-GWAS_pipeline.out" 2> "logs/BOLT-LMM-GWAS_pipeline.err"

# write that the pipeline is complete
echo "-----------------------------"
echo "      Pipeline Done!         "
