# Run on answer.csbi.mit.edu
# Need to run with sudo 

# directory to store input gVCF data flat
input_data_dir="/pool/data/globus/genomics_base/Sentieon_JG_Fall_2021/input_data"

# create temporary directory to store gVCF files flat
mkdir -p $input_data_dir


# get all files from NYGC pushed directory, ALS Consortium, Answer ALS, 1000 Genomes, RESPECTIVELY.
# get all haplotypeCalls files and their indices but avoid md5 files.
# make sure to exclude sequestered files.

# MAKE SURE ALL DATA THAT SHOULD BE THERE IS ACTUALLY THERE!
find \
    /pool/data/globus/PUSHED_FROM_NYGC/ \
    /pool/data/globus/genomics_other/ \
    /pool/data/globus/answer_als_genomics/ \
    /pool/data/globus/PUSHED_FROM_MIT/ \
    -iname "*haplotypeCalls.er.raw.vcf.gz*" ! -iname "*.md5" \
    -not -path "*/sequestered/*" \
    -type f \
    -exec ln '{}' $input_data_dir/ \; 

# rsync data from Answer to C3DDB-Globus
# do not use regular C3DDB which is much slower for data transfer
# use -e to specify linux private key
rsync -avr --human-readable --progress \
    -e "ssh -i /home/yraghav/clusters/c3ddb-cluster/linux/c3ddb-key" \
    /pool/data/globus/genomics_base/Sentieon_JG_Fall_2021/input_data/ \
    yraghav@c3ddb-globus.mit.edu:/scratch/users/yraghav/JG_2021_VCF_data/ 
    
# rsync FASTA input data
rsync -avr --human-readable --progress \
    -e "ssh -i /home/yraghav/clusters/c3ddb-cluster/linux/c3ddb-key" \
    /pool/data/globus/genomics_base/download_hg38_reference_09_14_2020/GRCh38_full_analysis_set_plus_decoy_hla.fa \
    /pool/data/globus/genomics_base/download_hg38_reference_09_14_2020/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai \
    yraghav@c3ddb-globus.mit.edu:/scratch/users/yraghav/Joint_Genotyping_inputs/fasta/