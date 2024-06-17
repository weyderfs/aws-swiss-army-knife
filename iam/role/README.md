# Commands for AWS IAM Roles
---

## List IAM Roles

`aws iam list-roles | jq -r '.Roles[] | .RoleName'`
