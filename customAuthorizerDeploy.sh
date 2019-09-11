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

. ./util/cognitoGetValues.sh

cd $essentialServicesPlatformRepoLocation/services/CustomAuthorizer

if [ $install = true ]
then
    rm -rf node_modules
    npm i --ignore-scripts
fi

npm run build && \
aws cloudformation package --template-file sam.yaml --s3-bucket $cloudformationPackageS3Bucket --output-template-file packaged.sam.yaml && \
aws cloudformation deploy --template-file packaged.sam.yaml --stack-name $customAuthorizerStackName --capabilities CAPABILITY_IAM --parameter-overrides VendorCognito=$vendorCognito  VendorCognitoAppClientId=$vendorCognitoAppClientId VendorCognitoPortalClientId=$vendorCognitoPortalClientId CustomerCognito=$customerCognito CustomerCognitoAppClientId=$customerCognitoAppClientId CustomerCognitoPortalClientId=$customerCognitoPortalClientId AdminCognito=$adminCognito AdminCognitoAppClientId=$adminCognitoAppClientId AdminCognitoPortalClientId=$adminCognitoPortalClientId AdminCognitoOutSystemsClientId=$adminCognitoPortalClientId
