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

export TF_VAR_do_token=xxx
export TF_VAR_dd_api_key=xxx
export TF_VAR_dd_app_key=xxx