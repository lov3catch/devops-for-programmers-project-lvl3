tf-init:
	terraform -chdir=terraform init

tf-plan:
	terraform -chdir=terraform plan

tf-apply:
	terraform -chdir=terraform apply

create-vault-pass-file:
	touch vault-password

ansible-encrypt-vault:
	ansible-vault encrypt --vault-password-file vault-password ansible/group_vars/webservers/vault.yml

ansible-decrypt-vault:
	ansible-vault decrypt --vault-password-file vault-password ansible/group_vars/webservers/vault.yml

ansible-install-deps:
	ansible-galaxy install -r ansible/requirements.yml

ansible-deploy:
	ansible-playbook -vv -i ansible/inventory.ini ansible/playbook.yml --vault-password-file=vault-password