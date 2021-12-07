### Hexlet tests and linter status:
[![Actions Status](https://github.com/lov3catch/devops-for-programmers-project-lvl3/workflows/hexlet-check/badge.svg)](https://github.com/lov3catch/devops-for-programmers-project-lvl3/actions)

[Ссылка на результат](http://botonarioum.one)

## Запуск
- Ansible: v2.11
- Python: v3.9
- Terraform: v1.0

### Создайте файл-секрет для Ansible и положите туда vault-пароль 
> make create-vault-pass-file

### Создайте файл с секретными переменными для Terraform
> touch terraform/secret.auto.tfvars

#### Пример содержимого файла terraform/secret.auto.tfvars
do_token="a5070c21715636ec1e8877f2d4fabe0b8e0f82700568d13a5865432f82c9404"
datadog_api_key="245fea81478a3583bb69842cb012d6c"
datadog_app_key="a0863207b32501b9ed86f58d91b3bec97758703"

### Готовим инфраструктуру:
> make tf-apply

### Готовим сервера:
> make ansible-deploy

### Для расшифровки/зашифровки vault - используйте команды
> make ansible-encrypt-vault

> ansible-decrypt-vault