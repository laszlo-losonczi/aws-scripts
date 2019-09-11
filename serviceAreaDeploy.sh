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

cd $essentialsVendorPortalPlatformRepoLocation/services/ServiceArea

if [ $install = true ] 
then
    rm -rf node_modules
    npm i --ignore-scripts
fi

securityGroupIds='sg-0e34a712eb0b8eacd'
vpcSubnetIds='subnet-0b475a9f6508bd047, subnet-071c1666129c1c7ab, subnet-019e9a724223393ed'
postgresConfigSecretKey='PostgresConfig'
postgresUser='master'
postgresDatabase='servicearea'
postgresPassword='}QD~oZ^J!1FrbD+9'
postgresHost="dev-dev-vendorrds-auroradbcluster-3zla53jo966e.cluster-cnwmjrjdobnt.us-east-1.rds.amazonaws.com"

npm run build && \
aws cloudformation package --template-file sam.yaml --s3-bucket $cloudformationPackageS3Bucket --output-template-file packaged.sam.yaml && \
aws cloudformation deploy --template-file packaged.sam.yaml --stack-name $serviceAreaStackName --capabilities CAPABILITY_IAM --no-fail-on-empty-changeset --parameter-overrides CustomAuthorizerArn=$customAuthorizerLambdaArn SecurityGroupIds=$securityGroupIds VpcSubnetIds="$vpcSubnetIds" PostgresConfigSecretKey=$postgresConfigSecretKey PostgresUser=$postgresUser PostgresDatabase=$postgresDatabase PostgresPassword=$postgresPassword PostgresHost=$postgresHost
