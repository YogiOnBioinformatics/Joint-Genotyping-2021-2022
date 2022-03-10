# must run on C3DDB

# uses absolute paths only 
# look through input gVCF data folder, sort, and save 
# NOTE: very important to sort the files and use same list for all JG shards
find /scratch/users/yraghav/JG_2021_VCF_data/ \
    -iname "*.vcf.gz" -type f | sort > \
    /scratch/users/yraghav/inputs/input_file_list/list.txt