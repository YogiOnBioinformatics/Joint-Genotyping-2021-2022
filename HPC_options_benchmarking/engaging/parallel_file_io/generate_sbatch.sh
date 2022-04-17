#!/bin/bash

regions=("50000001-51000000" "51000001-52000000" "52000001-53000000" "53000001-54000000" "54000001-55000000" "55000001-56000000" "56000001-57000000" "57000001-58000000" "58000001-59000000" "59000001-60000000" "60000001-61000000" "61000001-62000000" "62000001-63000000" "63000001-64000000" "64000001-65000000" "65000001-66000000" "66000001-67000000" "67000001-68000000" "68000001-69000000" "69000001-70000000" "70000001-71000000" "71000001-72000000" "72000001-73000000" "73000001-74000000" "74000001-75000000" "75000001-76000000" "76000001-77000000" "77000001-78000000" "78000001-79000000" "79000001-80000000" "80000001-81000000" "81000001-82000000" "82000001-83000000" "83000001-84000000" "84000001-85000000" "85000001-86000000" "86000001-87000000" "87000001-88000000" "88000001-89000000" "89000001-90000000" "90000001-91000000" "91000001-92000000" "92000001-93000000" "93000001-94000000" "94000001-95000000" "95000001-96000000" "96000001-97000000" "97000001-98000000" "98000001-99000000" "99000001-100000000")

for region in ${regions[@]}; do

    job_file="/nobackup1/yraghav/Joint_Genotyping/chr1_50mil_100mil/scripts/$region.sh"

    echo "#!/bin/bash
#SBATCH --output=/nobackup1/yraghav/Joint_Genotyping/chr1_50mil_100mil/output/${region}.txt
#SBATCH --error=/nobackup1/yraghav/Joint_Genotyping/chr1_50mil_100mil/error/${region}.txt
#SBATCH --mem=30GB
#SBATCH --constraint=centos7
#SBATCH --partition=sched_mit_hill
#SBATCH -N 1
#SBATCH -n 16

GVCFS=\`find /nobackup1/yraghav/chr1_50mil_100mil/ -iname \"*haplotypeCalls.er.raw.vcf.gz.tbi\" | perl -pe \"s/\.tbi//g; s/\n/ /g; s/^\//-v  \//g\"\`
export SENTIEON_LICENSE=\"answer.csbi.mit.edu:8990\"

/home/software/fraenkel/sentieon-genomics/bin/sentieon driver -t 16 --traverse_param 10000/200 --shard chr1:$region -r /nobackup1/yraghav/GRCh38_full_analysis_set_plus_decoy_hla.fa --algo GVCFtyper \$GVCFS /nobackup1/yraghav/Joint_Genotyping/chr1_50mil_100mil/output_vcf/final_chr1_$region.vcf.gz

" > $job_file
sbatch $job_file

done