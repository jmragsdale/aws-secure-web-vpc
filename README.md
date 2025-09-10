# AWS Secure Web VPC (Golden Baseline)
Secure-by-default VPC with private subnets only, SSM access (no SSH), WAF on ALB, GuardDuty/SecurityHub/Config enabled.
## Deploy
cd terraform && cp terraform.tfvars.example terraform.tfvars && terraform init && terraform apply -auto-approve
## Demo
- Connect via SSM Session Manager
- Show WAF managed rules & Security Hub findings
## Teardown
terraform destroy -auto-approve
