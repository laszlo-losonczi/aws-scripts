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

. ./util/vendorProfileGetValues.sh

cd $essentialsVendorPortalPlatformRepoLocation/services/WorkflowState

if [ $install = true ] 
then
    rm -rf node_modules
    npm i --ignore-scripts
fi

exportSender='importexport@infra.wip.prologis.com'
batchMailSender='plgs.pars@gmail.com'
exportAdmin='plgs.pars@gmail.com'

npm run build && \
aws cloudformation package --template-file sam.yaml --s3-bucket $cloudformationPackageS3Bucket --output-template-file packaged.sam.yaml && \
aws cloudformation deploy --template-file packaged.sam.yaml --stack-name $workflowStateStackName --capabilities CAPABILITY_IAM --no-fail-on-empty-changeset --parameter-overrides CloudFrontDistribution=$cloudFrontDistribution CustomAuthorizerArn=$customAuthorizerLambdaArn VendorProfilesTable=$vendorProfilesDbName VendorProfilesTableStream=$vendorProfilesDbStream ExportSender=$exportSender BatchMailSender=$batchMailSender ExportAdmin=$exportAdmin
