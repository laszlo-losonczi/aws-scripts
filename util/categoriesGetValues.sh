#! /bin/bash

. ./util/variables.sh

RESOURCE_TYPE_DYNAMO='AWS::DynamoDB::Table'

stackResources=$(aws cloudformation list-stack-resources --stack-name $categoriesStackName | jq '.StackResourceSummaries')

for index in $(echo $stackResources | jq -r 'keys | .[]')
do
    if [ $(echo $stackResources | jq -r ".[$index] | .ResourceType") == $RESOURCE_TYPE_DYNAMO ]
    then
        categoriesDbName=$(echo $stackResources | jq -r ".[$index] | .PhysicalResourceId")
        break
    fi
done