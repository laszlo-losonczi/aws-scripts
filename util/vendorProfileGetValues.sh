#! /bin/bash

. ./util/variables.sh

RESOURCE_TYPE_DYNAMO='AWS::DynamoDB::Table'

stackResources=$(aws cloudformation list-stack-resources --stack-name $vendorProfileStackName | jq '.StackResourceSummaries')

for index in $(echo $stackResources | jq -r 'keys | .[]')
do
    if [ $(echo $stackResources | jq -r ".[$index] | .ResourceType") == $RESOURCE_TYPE_DYNAMO ]
    then
        vendorProfilesDbName=$(echo $stackResources | jq -r ".[$index] | .PhysicalResourceId")
        break
    fi
done

stackOutputs=$(aws cloudformation describe-stacks --stack-name $vendorProfileStackName | jq '.Stacks[0].Outputs')

for index in $(echo $stackOutputs | jq 'keys | .[]'); do
    key=$(echo $stackOutputs | jq -r ".[$index] | .OutputKey")
    value=$(echo $stackOutputs | jq -r ".[$index] | .OutputValue")

    case "$key" in
    VendorProfilesTable)
        vendorProfilesDbStream=$value
        ;;
    esac
done
