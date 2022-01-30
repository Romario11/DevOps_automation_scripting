import sys
from urllib.parse import urlparse
import re
import boto3

print ("Number of arguments:", len(sys.argv))
print ("Argument List:", str(sys.argv))
s3 = boto3.resource('s3')
for bucket in s3.buckets.all():
    print(bucket.name)

#ParseResult(scheme='https', netloc='my-bucket-for-python-script.s3.eu-central-1.amazonaws.com', path='/my-folder/my-text.txt', params='', query='', fragment='')
o = urlparse("https://my-bucket-for-python-script.s3.eu-central-1.amazonaws.com/my-folder/my-text.txt")
print(o.netloc)
print(o.path)


m = re.search('^([a-z]+(-?[a-z]+)+)', o.netloc)

object = s3.Object('my-bucket-for-python-script','my-folder/my-text.txt')
print(object.get()['Body'].read())
print(m.group(0))
input("press")