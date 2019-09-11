#! /bin/bash

essentialServicesPlatformRepoLocation=/mnt/c/PROLOGIS/repos/EssentialServicesPlatform
essentialsVendorPortalPlatformRepoLocation=/mnt/c/PROLOGIS/repos/EssentialsVendorPortalPlatform
prefix='ll-dev'
region='eu-west-1'
cloudFrontDistribution=E1WQOLRV0UBRM3

# This is a custom resource, don't change unless you deploy it anywhere else than (DEV account-Ireland)
cognitoTriggerEnablerLambdaArn='arn:aws:lambda:eu-west-1:486649234389:function:ll-dev-custom-resource-po-PostConfirmationTriggerL-1QS6Y1MG1MZQJ'

cloudformationPackageS3Bucket="$prefix-packages"

cognitoStackName="$prefix-cognito"
customerCognitoPreSignUpStackName="$prefix-customer-cognito-pre-sign-up"
customAuthorizerStackName="$prefix-custom-authorizer"

customerProfileStackName="$prefix-customer-profile"
fileUploadStackName="$prefix-file-upload"
fixItStackName="$prefix-fix-it"
moveInToolStackName="$prefix-move-in-tool"
vendorTestUserConfirmationStackName="$prefix-vendor-test-user-confirmation"

categoriesStackName="$prefix-categories"
serviceAreaStackName="$prefix-service-area"
vendorProfileStackName="$prefix-vendor-profile"
workflowStateStackName="$prefix-workflow-state"
vendorCognitoPostConfirmationStackName="$prefix-vendor-cognito-post-confirmation"


buildingStackName="$prefix-building"

