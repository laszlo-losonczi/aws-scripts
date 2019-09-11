#! /bin/bash

. ./util/variables.sh

stackOutputs=$(aws cloudformation describe-stacks --stack-name $customerCognitoPreSignUpStackName | jq '.Stacks[0].Outputs')

for index in $(echo $stackOutputs | jq 'keys | .[]'); do
    key=$(echo $stackOutputs | jq -r ".[$index] | .OutputKey")
    value=$(echo $stackOutputs | jq -r ".[$index] | .OutputValue")

    case "$key" in
    LambdaResource)
        customerCognitoPreSignUpLambdaName=$value
        ;;
    esac
done

customerCognitoPreSignUpArn=$(aws lambda get-function --function-name $customerCognitoPreSignUpLambdaName | jq -r '.Configuration.FunctionArn')
