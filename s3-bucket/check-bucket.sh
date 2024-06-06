#!/bin/sh

# Get the list of all buckets
buckets=$(aws s3api list-buckets --profile prd | jq -r ".Buckets[].Name")

for bucket in $buckets; do
    echo "Checking bucket: $bucket"

    # Check bucket ACL for public access
    acl=$(aws s3api get-bucket-acl --bucket $bucket --profile prd | jq -r .)
    if echo $acl | grep -q 'AllUsers'; then
        echo "Bucket $bucket has public access through ACL"
        continue
    fi

    # Check bucket policy for public access
    policy_status=$(aws s3api get-bucket-policy-status --bucket $bucket --profile prd | jq -r .)
    if echo $policy_status | grep -q '"IsPublic": true'; then
        echo "Bucket $bucket has public access through policy"
        continue
    fi

    echo "Bucket $bucket is not public"
done
