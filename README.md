# Laravel 10 Boilerplate - Production DevOps Implementation
**Name:**  Emmanuel Michael Ibok
**Email:** ibokemmanuel17@gmail.com


## Table of Contents

- [Overview](#overview)
- [Project Architecture](#project-architecture)
- [Prerequisites](#prerequisites)
- [Local Development Setup](#local-development-setup)
- [Terraform Infrastructure](#terraform-infrastructure)
- [Helm Chart Deployment](#helm-chart-deployment)
- [CI/CD Pipeline](#cicd-pipeline)
- [Docker Configuration](#docker-configuration)
- [Security Considerations](#security-considerations)
- [Troubleshooting](#troubleshooting)

## Overview

This project implements a production ready DevOps pipeline for a Laravel 10 application.

Key capabilities include:

- Infrastructure as Code using Terraform
- AWS EKS Kubernetes cluster
- Multi stage Docker builds
- Helm based Kubernetes deployments
- GitLab CI CD with gated production releases
- Development, Staging, and Production environments
- Separate PHP FPM and Queue Worker deployments

---

## Project Architecture

### Infrastructure Overview

AWS VPC with public and private subnets across three availability zones.  
EKS nodes run only in private subnets.  
Docker images are stored in dockerhub registry.

### Kubernetes Application Layout

- Ingress with TLS termination
- ClusterIP service
- PHP FPM deployment with horizontal scaling
- Queue worker deployment with independent scaling
- ConfigMaps for configuration
- Secrets for sensitive values

---

## Prerequisites

### Required Tools

- AWS CLI v2
- Terraform v1.x
- Docker v20+
- kubectl v1.28+
- Helm v3
- Git

### Accounts and Access

- AWS account with EKS, VPC, IAM permissions
- GitLab account
- GitLab Runner configured for the project

---

## Local Development Setup

### Clone Repository

```bash
git clone https://gitlab.com/Emmylong1/laravel-10-boilerplate-task.git
cd laravel-10-boilerplate-task

The goal of this project is to serve as a boilerplate for Laravel 10
utilizing light-weight alpine linux images for nginx and php 8.2 (fpm).



Stack:

- app @ php:8.2-fpm-alpine
- nginx @ nginx:alpine
- mysql @ mysql
- redis @ redis:alpine
- worker-local @ php:8.2-alpine3.16

## TODO

- add a basic, highly optional seeder for user
- hook up worker-local so you have a queue to play with
- create an example job/worker you might co-locate on same hardware
- maybe add some ci/cd and even k8s stuff as an example to scale out workers/nginx/edges

## Notes

- docker/app docker/nginx will rely on supervisor to maintain their processes, yawn
- Please see .env "#PORT FORWARDS" before starting in docker-compose
-

## Installation

The default docker-compose config here exposes ports if you want them.  See .env's "PORT FORWARDS"

```shell
cp ./env.example ./.env
docker-compose up --build -d app nginx mysql

#docker-compose exec app php artisan migrate
```

You can now access http://localhost:8022 (or whatever your FORWARD_NGINX_PORT is).

Please keep ./composer.lock in docker/app container context, for example:

```shell
docker-compose exec -u root app /bin/sh
# then...
# COMPOSER_MEMORY_LIMIT=-1 app composer install
# COMPOSER_MEMORY_LIMIT=-1 app composer require awesome/package_etc
# ymmv w/ COMPOSER_MEMORY_LIMIT maybe try without
```
