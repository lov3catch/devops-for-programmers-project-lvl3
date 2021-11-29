tf-init:
	terraform -chdir=terraform init

tf-plan:
	terraform -chdir=terraform plan

tf-apply:
	terraform -chdir=terraform apply

ansible-encrypt-vault:
	ansible-vault encrypt --vault-password-file vault-password ansible/host_vars/localhost/vault.yml

ansible-decrypt-vault:
	ansible-vault decrypt --vault-password-file vault-password ansible/host_vars/localhost/vault.yml

ansible-install-deps:
	ansible-galaxy install -r ansible/requirements.yml

ansible-deploy:
	ansible-playbook -vv -i ansible/hosts.ini ansible/playbook.yml --vault-password-file=vault-password