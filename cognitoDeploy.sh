#! /bin/bash

. ./util/variables.sh

./customerCognitoPreSignUpDeploy.sh
. ./util/customerCognitoPreSignUpDeployGetValues.sh

aws cloudformation package --template-file util/cognito.yaml --s3-bucket $cloudformationPackageS3Bucket --output-template-file util/packaged.cognito.yaml && \
aws cloudformation deploy --template-file util/packaged.cognito.yaml --stack-name $cognitoStackName --no-fail-on-empty-changeset --parameter-overrides Prefix=$prefix CustomerCognitoPreSignUp=$customerCognitoPreSignUpArn

