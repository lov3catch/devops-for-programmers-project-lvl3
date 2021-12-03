### Hexlet tests and linter status:
[![Actions Status](https://github.com/lov3catch/devops-for-programmers-project-lvl3/workflows/hexlet-check/badge.svg)](https://github.com/lov3catch/devops-for-programmers-project-lvl3/actions)

[Ссылка на результат](http://botonarioum.one)

#### Шаг №1
- [X] Настройте Terraform Backend для хранения состояния в Terraform Cloud
- [X] Создайте две машины в DO
- [X] Заведите их под балансировщик нагрузки
- [X] Добавьте на балансировщик сертификат
- [X] Добавьте на эти машины публичные ключи. Проверьте что работает ssh доступ
- [X] Добавьте базу данных (как сервис), Если приложение может работать с ней
- [X] Добавьте команды настройки (инициации проекта) и часто используемые команды в Makefile
- [X] Проверьте, что инфраструктура создается и удаляется без ошибок

#### Шаг №2
- [X] Опишите в Makefile команды подготовки и деплоя. В README.md напишите примеры использования этих команд
- [X] Используйте ваш проект (любой), который уже упакован в образ Docker
- [X] Задеплойте проект с помощью Ansible на созданную инфраструктуру
- [X] Добавьте в README.md ссылку на задеплоенное приложение (домен, который указывает на балансировщик)

#### Шаг №3
- [X] Установите с помощью Ansible агент DataDog на машины
- [X] Создайте Alert в DataDog используя Terraform. Он должен проверять насколько приложение "живое" выполняя HTTP запросы к экземпляру приложения на своем сервере

#### Шаг №4
- [X] [Зарегистрируйтесь](https://www.freshworks.com/website-monitoring/signup/) в сервисе Freshping и добавьте в мониторинг страницу с вашим проектом

#### Дополнительно
- [ ] Бастион?
- [ ] Отдельный пользователь для Docker
- [ ] Обновить ридми

#### С какими проблемами столкнулся: 
- Ansible не поддерживает именованые воркспейсы, так что пришлось сменить на префикс [info](https://github.com/ansible/ansible/issues/59089)
- Ansible не поддерживает remote execution, так что пришлось переключить на local в Terraform Cloud [info](https://discuss.hashicorp.com/t/saving-a-generated-plan-is-currently-not-supported/2116)

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