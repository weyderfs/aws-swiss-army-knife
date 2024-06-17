# Commands for AWS IAM Policy
---

## List IAM Policies Custom Managed

`aws iam list-policies --scope Local | jq -r '.Policies[] | .PolicyName'`
