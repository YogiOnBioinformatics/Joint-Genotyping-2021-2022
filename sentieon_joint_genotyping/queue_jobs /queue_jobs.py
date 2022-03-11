############################
# MUST BE RUN ON C3DDB!!!! #
############################
# USAGE: 
# python3 queue_jobs.py 

import glob, os


"""
Literals
"""
scripts_dir = "/scratch/users/yraghav/output/SLURM/scripts"
error_dir = "/scratch/users/yraghav/output/SLURM/error"
output_dir = "/scratch/users/yraghav/output/SLURM/output"
shards_file = "/scratch/users/yraghav/inputs/shards/shards.txt"
JG_output_dir = "/scratch/users/yraghav/output/Joint_Genotyping"

memory="250GB"
num_nodes = "1"
num_threads = "64"
partition = "sched_mem1TB_centos7"

# NOTE: 'exclude_node_list' may not be relevant anymore.
# In February 2022, C3DDB admins incorrectly thought that all nodes on partition 'sched_mem1TB_centos7' had a ~65K ulimit.
# This wasn't the case and they were working on a solution.
# As of March 2022, these nodes need to be excluded due to low ulimit.
exclude_node_list = "node[301-307,320-324,327-331]"

sentieon_tmpdir = "/scratch/users/yraghav/sentieon_tmpdir"
sentieon_license = "answer.csbi.mit.edu:8990"
cache_size="4096"
jemalloc_path="/scratch/users/yraghav/sentieon-genomics-202112/lib/libjemalloc.so.1"
sentieon_exec = "/scratch/users/yraghav/sentieon-genomics-202112/bin/sentieon"
reference_fasta = "/scratch/users/yraghav/inputs/fasta/GRCh38_full_analysis_set_plus_decoy_hla.fa"
input_file_list = "/scratch/users/yraghav/inputs/input_file_list/list.txt"


"""
Load Shards
"""

shards = []

with open(shards_file, "r") as in_file:
    for line in in_file:
        shards.append(line.strip("\n"))


"""
Identify Completed Shards
"""

error_files = glob.glob("{}/*.txt".format(error_dir))

for error_file in error_files:

    progress_100_flag=False 
    completion_flag=False
        
    with open(error_file, "r") as in_file:
        for line in in_file:
            if "cmdline" not in line:
                if "progress 100%" in line:
                    progress_100_flag = True
                elif "overall:" in line:
                    completion_flag = True
    
    if progress_100_flag and completion_flag:
        shards.remove("{}:{}-{}".format(
                error_file.split("/")[-1].split(".")[0].split("-")[0],
                error_file.split("/")[-1].split(".")[0].split("-")[1],
                error_file.split("/")[-1].split(".")[0].split("-")[2]
            )
        )

"""
Create Scripts
"""

for shard in shards:

    hyphenated_shard = shard.replace(":", "-")

    with open("{}/{}.sh".format(scripts_dir, hyphenated_shard), "w") as out_file:

        out_file.write("#!/bin/bash\n")
        out_file.write("#SBATCH --job-name={}\n".format(hyphenated_shard))
        out_file.write("#SBATCH --output={}/{}_output.txt\n".format(output_dir, hyphenated_shard))
        out_file.write("#SBATCH --error={}/{}_error.txt\n".format(error_dir, hyphenated_shard))
        out_file.write("#SBATCH --mem={}\n".format(memory))
        out_file.write("#SBATCH --partition={}\n".format(partition))
        out_file.write("#SBATCH -N {}\n".format(num_nodes))
        out_file.write("#SBATCH -n {}\n".format(num_threads))
        out_file.write("#SBATCH -x {}\n".format(exclude_node_list))

        out_file.write("\n\n")

        out_file.write("export SENTIEON_TMPDIR={}\n".format(sentieon_tmpdir))
        out_file.write("export SENTIEON_LICENSE={}\n".format(sentieon_license))
        out_file.write("export VCFCACHE_BLOCKSIZE={}\n".format(cache_size))
        out_file.write("export LD_PRELOAD={}\n".format(jemalloc_path))

        out_file.write("\n\n")

        out_file.write(
            "{} driver -t {} --traverse_param 10000/200 --shard {} -r {} --algo GVCFtyper {}/{}.vcf.gz - < {} \n".format(
                sentieon_exec,
                num_threads,
                shard,
                reference_fasta,
                JG_output_dir,
                hyphenated_shard,
                input_file_list
            ) 
        )

    os.system("sbatch {}/{}.sh".format(scripts_dir, hyphenated_shard))
