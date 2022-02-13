# Requirements
1.	Installed AWS CLI
2.	Configured AWS CLI
3.	Installed Python 3.*.*
4.	Installed Boto3

# Getting Started

1.	# ./ipreleases.sh us-east-1 us-east-2 us-west-1 us-west-2 eu-central-1
    # -script---------arguments with space separator----------------------


2.	# exemple: .\instance_startStopper.ps1 start eu-central-1 i-03013c23f3627ec35,i-03564d05062d4c6ea,          i-0048dd187dce64e42
    # ------------name of script--------state--region------instances ID without spaces, separete by coma--------


3.	# exemple: .\obj_print.py https://my-bucket-for-python-script.s3.eu-central-1.amazonaws.com/my-text.txt
    # ------------name of script--------URL to S3 object--------