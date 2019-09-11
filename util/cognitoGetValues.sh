#! /bin/bash

. ./util/variables.sh

stackOutputs=$(aws cloudformation describe-stacks --stack-name $cognitoStackName | jq '.Stacks[0].Outputs')

for index in $(echo $stackOutputs | jq 'keys | .[]'); do
    key=$(echo $stackOutputs | jq -r ".[$index] | .OutputKey")
    value=$(echo $stackOutputs | jq -r ".[$index] | .OutputValue")

    case "$key" in
    AdminCognitoPoolUrl)
        adminCognito=$value
        ;;
    EssentialsAdminAppRoleClientId)
        adminCognitoAppClientId=$value
        ;;
    EssentialsAdminPortalRoleClientId)
        adminCognitoPortalClientId=$value
        ;;
    CustomerCognitoPoolUrl)
        customerCognito=$value
        ;;
    CustomerCognitoArn)
        customerCognitoArn=$value
        ;;
    CustomerCognitoPoolId)
        customerCognitoPoolId=$value
        ;;
    EssentialsCustomerAppRoleClientId)
        customerCognitoAppClientId=$value
        ;;
    EssentialsCustomerPortalRoleClientId)
        customerCognitoPortalClientId=$value
        ;;
    VendorCognitoPoolUrl)
        vendorCognito=$value
        ;;
    VendorCognitoArn)
        vendorCognitoArn=$value
        ;;
    VendorCognitoPoolId)
        vendorCognitoPoolId=$value
        ;;
    EssentialsVendorAppRoleClientId)
        vendorCognitoAppClientId=$value
        ;;
    EssentialsVendorPortalRoleClientId)
        vendorCognitoPortalClientId=$value
        ;;
    esac
done
