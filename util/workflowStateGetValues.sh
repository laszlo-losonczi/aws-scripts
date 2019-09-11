#! /bin/bash

. ./util/variables.sh

stateChangeLogicalId='VendorProfileStateChange'

stackResources=$(aws cloudformation list-stack-resources --stack-name $workflowStateStackName | jq '.StackResourceSummaries')

for index in $(echo $stackResources | jq -r 'keys | .[]')
do
    if [ $(echo $stackResources | jq -r ".[$index] | .LogicalResourceId") == $stateChangeLogicalId ]
    then
        setWorkflowStateLambdaArn=$(aws lambda get-function --function-name $(echo $stackResources | jq -r ".[$index] | .PhysicalResourceId") | jq -r '.Configuration.FunctionArn')
        break
    fi
done
