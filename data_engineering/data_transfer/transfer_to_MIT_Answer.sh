# rsync data from C3DDB-Globus to Answer
# do not use regular C3DDB which is much slower for data transfer
# use -e to specify linux private key
rsync -avr --human-readable --progress \
    -e "ssh -i /home/yraghav/clusters/c3ddb-cluster/linux/c3ddb-key" \
    yraghav@c3ddb-globus.mit.edu:/scratch/users/yraghav/output/Joint_Genotyping/ \
    /pool/data/globus/genomics_base/Sentieon_JG_Fall_2021_and_2022/shards/ \
