#!/bin/bash

regions=("1-25000000" "25000001-50000000" "50000001-75000000" "75000001-100000000" "100000001-125000000" "125000001-150000000" "150000001-175000000" "175000001-198295559")

for region in ${regions[@]}; do

job_file="/scratch/users/yraghav/Joint_Genotyping/chr3/scripts/${region}.sh"

    echo "#!/bin/bash
#SBATCH --output=/scratch/users/yraghav/Joint_Genotyping/chr3/output/${region}.txt
#SBATCH --error=/scratch/users/yraghav/Joint_Genotyping/chr3/error/${region}.txt
#SBATCH --mem=130GB
#SBATCH --partition=sched_mem1TB_centos7
#SBATCH -N 1
#SBATCH -n 48

GVCFS=\`find /scratch/users/yraghav/chr3/ -iname \"*haplotypeCalls.er.raw.vcf.gz.tbi\" | perl -pe \"s/\.tbi//g; s/\n/ /g; s/^\//-v  \//g\"\`
export SENTIEON_LICENSE=\"answer.csbi.mit.edu:8990\"

/scratch/users/yraghav/sentieon-genomics/bin/sentieon driver -t 48 --traverse_param 10000/200 --shard chr3:$region -r /scratch/users/yraghav/GRCh38_full_analysis_set_plus_decoy_hla.fa --algo GVCFtyper \$GVCFS /scratch/users/yraghav/Joint_Genotyping/chr3/output_vcf/chr3_${region}.vcf.gz

" > $job_file
sbatch $job_file

done