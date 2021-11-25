tf-init:
	terraform -chdir=terraform init

tf-plan:
	terraform -chdir=terraform plan

tf-apply:
	terraform -chdir=terraform apply

ansible-install-deps:
	ansible-galaxy install -r ansible/requirements.yml

ansible-run:
	ansible-playbook -vv -i ansible/hosts.ini ansible/playbook.yml