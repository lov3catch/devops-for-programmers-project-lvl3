plan:
	terraform -chdir=terraform plan

init:
	terraform -chdir=terraform init

prepare-infra:
	terraform -chdir=terraform apply