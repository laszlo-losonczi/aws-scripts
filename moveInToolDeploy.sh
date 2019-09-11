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

cd $essentialServicesPlatformRepoLocation/services/MoveInTool

if [ $install = true ] 
then
    rm -rf node_modules
    npm i --ignore-scripts
fi

npm run build && \
aws cloudformation package --template-file sam.yaml --s3-bucket $cloudformationPackageS3Bucket --output-template-file packaged.sam.yaml && \
aws cloudformation deploy --template-file packaged.sam.yaml --stack-name $moveInToolStackName --capabilities CAPABILITY_IAM --no-fail-on-empty-changeset --parameter-overrides CustomAuthorizerArn=$customAuthorizerLambdaArn CloudFrontDistribution=$cloudFrontDistribution
