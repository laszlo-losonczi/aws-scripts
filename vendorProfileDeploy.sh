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

. ./util/customAuthorizerGetValues.sh

. ./util/cognitoGetValues.sh

. ./util/categoriesGetValues.sh

cd $essentialsVendorPortalPlatformRepoLocation/services/VendorProfile

if [ $install = true ] 
then
    rm -rf node_modules
    npm i --ignore-scripts
fi

vendorNotificationSource='importexport@infra.wip.prologis.com'
vendorNotificationDestination='plgs.pars@gmail.com'
serviceAreaUrl='' # TODO

npm run build && \
aws cloudformation package --template-file sam.yaml --s3-bucket $cloudformationPackageS3Bucket --output-template-file packaged.sam.yaml && \
aws cloudformation deploy --template-file packaged.sam.yaml --stack-name $vendorProfileStackName --capabilities CAPABILITY_IAM --no-fail-on-empty-changeset --parameter-overrides CloudFrontDistribution=$cloudFrontDistribution CustomAuthorizerArn=$customAuthorizerLambdaArn CognitoUserPoolArn=$vendorCognitoArn CognitoUserPoolId=$vendorCognitoPoolId CognitoClientId=$vendorCognitoAppClientId VendorNotificationSource=$vendorNotificationSource VendorNotificationDestination=$vendorNotificationDestination ServiceAreaUrl=$serviceAreaUrl CategoriesDB=$categoriesDbName