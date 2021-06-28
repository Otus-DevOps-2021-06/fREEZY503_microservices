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

## Docker-3
В процессе сделано:
 - Основное задание:
   - Собрал три образа для сервисов, создал для них специальную сеть 
   - Запустил контейнеры с образами приложения
   - Улучшил и собрал образ ui с тегом 2.0, уменьшив его вес
   - Создал Docker volume и подключил его к контейнеру с MongoDB 
   ~~~bash
   docker volume create reddit_db
   docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
   ~~~
- Задание с *:
   - Запустил контейнеры с другими сетевыми алиасами, адреса для взаимодействия контейнеров задал через ENV-переменные
   ~~~bash
   docker run -d --network=reddit --network-alias=post_db_1 --network-alias=comment_db_1 mongo:latest
   docker run -d --network=reddit --network-alias=posts_1 --env POST_DATABASE_HOST=post_db_1 --env POST_DATABASE=posts_1 freezy503/post:1.0
   docker run -d --network=reddit --network-alias=comment_1 --env COMMENT_DATABASE_HOST=comment_db_1 --env COMMENT_DATABASE=comments_1 freezy503/comment:1.0
   docker run -d --network=reddit --env POST_SERVICE_HOST=posts_1 --env COMMENT_SERVICE_HOST=comment_1 -p 9292:9292 freezy503/ui:1.0
   ~~~
- Задание с *:
   - Собрал образы на основе Alpine Linux для ui, comment сервисов (post сервис уже основан на alpine)
   ~~~bash
   docker build -t freezy503/ui:3.0 ./ui/ -f ./ui/Dockerfile.1 
   docker build -t freezy503/comment:2.0 ./comment/ -f ./ui/Dockerfile.1
   ~~~
   - Запуск контейнеров
   ~~~bash
   docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:latest
   docker run -d --network=reddit --network-alias=post freezy503/post:1.0
   docker run -d --network=reddit --network-alias=comment freezy503/comment:2.0
   docker run -d --network=reddit -p 9292:9292 freezy503/ui:3.0
   ~~~
