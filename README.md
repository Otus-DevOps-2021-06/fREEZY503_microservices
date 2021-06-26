# fREEZY503_microservices
fREEZY503 microservices repository

## Docker-2
В процессе сделано:
 - Основное задание:
    - Создание docker host
    - Создание своего образа
    - Работа с Docker Hub
 - Задание с *:
	- Сравнил вывод двух команд (ответ в docker-monolith/docker-1.log): 
        ~~~bash
        docker inspect <u_container_id>
        docker inspect <u_image_id>
        ~~~
 - Задание с *:
    - Автоматизировал поднятие нескольких инстансов в Yandex Cloud, установку на них докера и запуск там образа freezy503/otus-reddit:1.0
        - Packer
        ~~~bash
        cd docker-monolith/infra/packer && packer build --var-file=variables.json reddit_in_docker.json 
        ~~~
        - Terraform
        ~~~bash
        cd docker-monolith/infra/terraform terraform && terraform init && terraform apply -auto-approve
        ~~~
        - Ansible
        ~~~bash
        sh dynamic.sh --environment stage --list
        ~~~
