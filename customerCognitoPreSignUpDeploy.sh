#! /bin/bash

install=false

while getopts ":i" o; do
    case "${o}" in
    i)
        install=true
        ;;
    esac
done

. ./util/variables.sh

cd $essentialServicesPlatformRepoLocation/services/CognitoAutoConfirmSignUp

if [ $install = true ]
then
    rm -rf node_modules
    npm i --ignore-scripts
fi

npm run build && \
aws cloudformation package --template-file sam.yaml --s3-bucket $cloudformationPackageS3Bucket --output-template-file packaged.sam.yaml && \
aws cloudformation deploy --template-file packaged.sam.yaml --stack-name $customerCognitoPreSignUpStackName --capabilities CAPABILITY_IAM