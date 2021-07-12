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

## Docker-4
В процессе сделано:
 - Основное задание:
   - Разобрался с работой сети в Docker 
      - none
      - host
      - bridge
   - Собрал образы приложений с помощью docker-compose и с помощью него запустил приложение
   ~~~bash
   docker-compose up -d
   ~~~

- Задание с *:
   - Создал docker-compose.override.yml для reddit проекта, который позволит:
      - Запускать puma для руби приложений в дебаг режиме с двумя воркерами (флаги --debug и -w 2)

Базовое имя проекта образуется как имя директории в которой находится файл docker-compose.yml. Имя проекта можо изменить добавлением параметра --project-name NAME при запуске проекта (например, docker-compose --project-name test up -d)

## Monitoring-1
В процессе сделано:
 - Основное задание:
   - Prometheus: запуск, конфигурация, знакомство с Web UI
   - Мониторинг состояния микросервисов
   - Сбор метрик хоста с использованием экспортера
- Задание со *:
   - Добавил в Prometheus мониторинг MongoDB с использованием необходимого экспортера (bitnami/mongodb-exporter).
- Задание со *:   
   - Добавил в Prometheus мониторинг сервисов comment, post, ui с помощью blackbox экспортера.


## Monitoring-2

https://hub.docker.com/u/freezy503

В процессе сделано:
 - Основное задание:
   - Мониторинг Docker контейнеров
   - Визуализация метрик
   - Сбор метрик работы приложения и бизнес метрик
   - Настройка и проверка алертинга
- Задание со *:
   - Добавил сбор метрик с докера в Prometheus, добавил дашборд для этого.
   - Добавил сбор метрик с докера с помощью telegraf в Prometheus, добавил дашборд для этого.
   - Придумал и реализовал алерт на 95 процентиль времени ответа UI.

## Logging-1

В процессе сделано:
 - Основное задание:
   - Подготовка окружения
   - Логирование Docker-контейнеров
   - Сбор неструктурированных логов
   - Визуализация логов
   - Сбор структурированных логов
   - Распределенный трейсинг
- Задание со *:
   - Составил конфигурацию Fluentd так, чтобы разбирались оба формата логов UI-сервиса одновременно.
- Задание со *:
   - Выяснил проблему долгой загрузки страницы с постом с помощью Zipkin. Проблема заключается в долгой загрузке метода GET из-за строчки time.sleep(3) в файле post_app.py.

## Kubernetes-1

В процессе сделано:
 - Основное задание:
   - Разобрал на практике все компоненты Kubernetes, развернул их вручную используя kubeadm
   - Ознакомился с описанием основных примитивов приложения и его дальнейшим запуском в Kubernetes
- Задание со *:
   - Описал установку кластера k8s с помощью terraform и ansible

## Kubernetes-2

В процессе сделано:
 - Основное задание:
   - Развернул локальное окружение для работы с Kubernetes
   - Развернул Kubernetes в Yandex Cloud
   - Запустил reddit в Kubernetes
- Задание со *:
   - Развернул Kubernetes-кластер в Yandex cloud с помощью Terraform модуля
   - Создал YAML-манифесты для описания созданных сущностей для включения dashboard (dashboard/)

## Kubernetes-3

В процессе сделано:
 - Основное задание:
   - Выполнил задание с Ingress и Ingress Controller
   - Выполнил задание с Secret и TLS
   - Добавил LoadBalancer Service
   - Добавил PersistentVolumes и PersistentVolumesClaims
- Задание со *:
   - Описал создаваемый объект Secret в виде Kubernetes-манифеста (secret.yml)

## Kubernetes-4

В процессе сделано:
 - Основное задание:
   - Работа с Helm
   - Развертывание Gitlab в Kubernetes
   - Запуск CI/CD конвейера в Kubernetes
- Задание со *:
   - Связал пайплайны сборки образов и пайплайн деплоя на staging и production так, чтобы после релиза образа из ветки мастер запускался деплой уже новой версии приложения на production
   