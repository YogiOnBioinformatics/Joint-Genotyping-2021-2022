#!/bin/bash
#SBATCH --job-name=chr3-100000001-198295559
#SBATCH --output=/scratch/users/yraghav/output/SLURM/output/chr3-100000001-198295559_output.txt
#SBATCH --error=/scratch/users/yraghav/output/SLURM/error/chr3-100000001-198295559_error.txt
#SBATCH --mem=250GB
#SBATCH --partition=sched_mem1TB_centos7
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -x node[301-307,320-324,327-331]


export SENTIEON_TMPDIR=/scratch/users/yraghav/sentieon_tmpdir
export SENTIEON_LICENSE=answer.csbi.mit.edu:8990
export VCFCACHE_BLOCKSIZE=4096
export LD_PRELOAD=/scratch/users/yraghav/sentieon-genomics-202112/lib/libjemalloc.so.1


/scratch/users/yraghav/sentieon-genomics-202112/bin/sentieon driver -t 64 --traverse_param 10000/200 --shard chr3:100000001-198295559 -r /scratch/users/yraghav/inputs/fasta/GRCh38_full_analysis_set_plus_decoy_hla.fa --algo GVCFtyper /scratch/users/yraghav/output/Joint_Genotyping/chr3-100000001-198295559.vcf.gz - < /scratch/users/yraghav/inputs/input_file_list/list.txt 