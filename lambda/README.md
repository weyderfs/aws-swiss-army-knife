# Following the Tips and Tricks using the AWS CLI for Lambdas
---

## List Lambdas by Function Names

`$ aws lambda list-functions --region sa-east-1 | jq -r '.Functions[] | .FunctionName'`

## List Lambdas by Function Name and Filter by LastModified

`aws lambda list-functions | jq -r '.Functions[] | [.FunctionName,.LastModified] | join (" ~~>> ")'`

## Get Lambda Functions and Policy from them
for x in $(aws lambda list-functions --region sa-east-1 | jq -r '.Functions[].FunctionName')
do
  echo aws lambda get-policy --region sa-east-1 --function-name $x
done

## Get Logs filtered by Lambdas log-group
aws logs describe-log-groups | jq -r '.logGroups[].logGroupName' | egrep -e /aws/lambda

## Get Logs from Lambdas concatenating LogroupName + Last Log Stream of them
#!/bin/bash

# LOG_GROUP=$(aws logs describe-log-groups --region sa-east-1 | jq -r '.logGroups[].logGroupName' | egrep -e /aws/lambda | sort)
# LOG_STREAM=" "

# for x in $LOG_GROUP 
# do
#   LOG_STREAM="$LOG_STREAM$(aws logs describe-log-streams --log-group-name $x --max-items 1 --order-by LastEventTime --descending | jq -r '.logStreams[].logStreamName')"
# done

# read $LOG_GROUP $LOG_STREAM
# R="$LOG_GROUP ; $LOG_STREAM"
# echo $R

LOG_GROUP=$(aws logs describe-log-groups --region sa-east-1| jq -r '.logGroups[].logGroupName' | egrep -e /aws/lambda | sort)

for x in $LOG_GROUP 
do
  echo "$x;$(aws logs describe-log-streams --log-group-name $x --max-items 1 --order-by LastEventTime --descending | jq -r '.logStreams[].logStreamName')"
done

