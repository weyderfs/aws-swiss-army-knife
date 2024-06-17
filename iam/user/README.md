# Commands for AWS IAM Users
---

## List IAM Users

`aws iam list-users | jq -r '.Users[] | .UserName'`
