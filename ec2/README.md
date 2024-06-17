# The EC2 commands
---

## List EC2 AMI's group by ID and TagName handling with null values

`aws ec2 describe-images --owners <owner-id> --region sa-east-1 | jq '.Images[] | [.ImageId,.Tags[]?.Value] | join(";")'`

## List EC2 Instances group by Tag Name and InstanceType

`aws ec2 describe-instances --region sa-east-1 | jq '.Reservations[].Instances[] | [.InstanceType,.Tags[].Value] | join(";")'`

## List EC2 Snapshots

`aws ec2 describe-snapshots --region <the-region> --owner-id <123456789> | jq -r '.Snapshots[] | [.SnapshotId,.Description] | join(" ")' | sort`
