# Joint Genotyping 2021-2022

<br>
<img src="https://support.sentieon.com/manual/_static/companylogo.png" style="width:500px;height:100px">
<br>
<br>

This repository contains all the information to reproduce the Joint Genotyping run from Fall 2021 till Spring 2022. 

## Chronology: 

1. `data_engineering/size_estimation/JG_input_data_size_estimation.ipynb`
2. `data_engineering/data_transfer/transfer.sh`
3. `data_engineering/delete_duplicates/notebook/choose_representative_sample.ipynb`
4. `data_engineering/delete_duplicates/output/remove_repeated_samples_data.sh`
5. `sentieon_joint_genotyping/gvcf_input_file/scripts/create_gvcf_sorted_input_list.sh`
6. `sentieon_joint_genotyping/shards/notebook/create_shards.ipynb`
7. `sentieon_joint_genotyping/queue_jobs/queue_jobs.py`
8. `data_engineering/data_transfer/transfer_to_MIT_Answer.sh`
<br>

## Representative Overview Figure: 

<br>
<img src="https://i0.wp.com/images.squarespace-cdn.com/content/v1/5ea57eb1c6398826cb20f779/1594826700669-UQCPD472Z3CX8X5LTZOX/ke17ZwdGBToddI8pDm48kP8w85gLkngkQ_FRn7mAj8hZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZUJFbgE-7XRK3dMEBRBhUpwQubD-KGwRVfwb6ubM5SVMDJduzuVpMDxbTfRxfdLPF9Og1AwerCUiOkKpDB0uqgQ/0*OEe5JlQ3xsgl6saO.png?w=1160&ssl=1">

[Source](https://dnastack.com/joint-genotyping-10k-whole-genome-sequences-using-sentieon-on-google-cloud-strategies-for-analyzing-large-sample-sets/)
