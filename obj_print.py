import sys
from urllib.parse import urlparse
import re
import boto3

def out_red(text):
    print("\033[31m {}" .format(text))
    print("\033[37m {}" .format(''))
def out_green(text):
    print("\033[33m {}" .format('Content from s3 object is:\n'))
    print("\033[32m {}" .format(text))
    print("\033[37m {}" .format(''))
def out_yellow(text):
    print("\033[33m {}" .format(text))
    print("\033[37m {}" .format(''))
def out_blue(text):
    print("\033[34m {}" .format(text))
    print("\033[37m {}" .format(''))


if ( len(sys.argv) < 2 or (not bool(re.search('^https://.+',sys.argv[1])))):
    out_red('Something wrong with argument. Please enter correct URL')
    exit()


inputURL = str(sys.argv[1])


def parseOldS3UrlFormat(Url):
    parsedObject = urlparse(Url)
    backetName = re.match('^([a-z])+(([a-z])?([0-9])?(-)?)+',parsedObject.path[1:]).group(0)
    objectKey = re.sub('^([a-z])+(([a-z])?([0-9])?(-)?)+/','',parsedObject.path[1:])
    return {'backetName' : backetName, 'objectKey': objectKey}


def parseNewS3UrlFormat(Url):
    parsedObject = urlparse(Url)
    backetName = re.match('^([a-z])+(([a-z])?([0-9])?(-)?)+', parsedObject.netloc).group(0)
    objectKey = parsedObject.path[1:]
    return {'backetName' : backetName, 'objectKey': objectKey}


def getObjectContent(listOfObjectData):
    s3 = boto3.resource('s3')
    S3object = s3.Object(listOfObjectData.get('backetName'),listOfObjectData.get('objectKey'))
    return S3object.get()['Body'].read().decode()
    

if ( bool(re.search('^(https://s3\.)',inputURL))):
    listOfObjectData = parseOldS3UrlFormat(inputURL)
    out_green(getObjectContent(listOfObjectData))
else:
    listOfObjectData = parseNewS3UrlFormat(inputURL)
    try:
        out_green(getObjectContent(listOfObjectData))
    except Exception as e:
        out_red("Error! Wrong URL or AWS CLI not configured")
        exit()

out_blue('The script completed successfully')