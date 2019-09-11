#! /bin/bash

. ./util/variables.sh

RESOURCE_TYPE_LAMBDA='AWS::Lambda::Function'

stackResources=$(aws cloudformation list-stack-resources --stack-name $customAuthorizerStackName | jq '.StackResourceSummaries')

for index in $(echo $stackResources | jq -r 'keys | .[]')
do
    if [ $(echo $stackResources | jq -r ".[$index] | .ResourceType") == $RESOURCE_TYPE_LAMBDA ]
    then
        customAuthorizerLambdaArn=$(aws lambda get-function --function-name $(echo $stackResources | jq -r ".[$index] | .PhysicalResourceId") | jq -r '.Configuration.FunctionArn')
        break
    fi
done