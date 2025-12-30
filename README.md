# Laravel 10 Boilerplate - Production DevOps Implementation

<!-- Project README Header -->

<div align="center">
  <h3>Cloud Native Architecture • CI CD • Kubernetes Ready</h3>
</div>

<p align="center">
  <em>
    This repository demonstrates a modern DevOps driven approach to building,
    testing, and deploying a scalable Laravel application using containerization,
    infrastructure as code, and automated delivery pipelines.
  </em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/CI-CD%20Enabled-brightgreen?style=flat-square" />
  <img src="https://img.shields.io/badge/Docker-Containerized-blue?style=flat-square&logo=docker" />
  <img src="https://img.shields.io/badge/Kubernetes-Ready-blue?style=flat-square&logo=kubernetes" />
    <img src="https://img.shields.io/badge/Helm-Package%20Manager-0F1689?style=flat-square&logo=helm" />
  <img src="https://img.shields.io/badge/Infrastructure-Terraform-purple?style=flat-square&logo=terraform" />
</p>

<hr />



**Name:**  Emmanuel Michael Ibok
**Email:** ibokemmanuel17@gmail.com


## Architecture Diagram

![Architecture Diagram](docs/diagram-export-12-28-2025-4_43_06-PM.png)

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

## Infrastructure and Deployment Documentation

This section explains how infrastructure, application deployment, and CI/CD are implemented in this project.

---

## Laravel 10 Boilerplate DevOps Infrastructure

This repository contains a complete production ready DevOps setup for a Laravel 10 application, including infrastructure provisioning, containerization, Kubernetes deployment, and CI/CD automation.

---

## Repository Structure

```text
.
├── helm-chart/
│   └── laravel-app/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│           ├── _helpers.tpl
│           ├── configmap.yaml
│           ├── deployment-phpfpm.yaml
│           ├── deployment-worker.yaml
│           ├── hpa-phpfpm.yaml
│           ├── hpa-worker.yaml
│           ├── ingress.yaml
│           ├── secret.yaml
│           └── service.yaml
│
├── laravel-10-boilerplate-infra-task/
│   ├── environments/
│   │   ├── dev/
│   │   ├── staging/
│   │   └── production/
│   │
│   └── modules/
│       ├── vpc/
│       ├── security-group/
│       ├── eks/
│       └── rds/
│
└── README.md



## Helm Chart Structure

The Helm chart is located in `helm-chart/laravel-app` and is responsible for deploying the Laravel application to Kubernetes in a production ready manner.

### Chart.yaml

Defines the Helm chart metadata such as:
- Chart name
- Version
- Description

---

### values.yaml

Contains configurable values used across environments, including:
- Image repository and tag
- Replica counts
- Resource limits and requests
- Environment variables

---

### templates/

This directory contains the Kubernetes manifests rendered by Helm.

- `_helpers.tpl`  
  Shared template helpers for naming conventions and labels.

- `configmap.yaml`  
  Defines non sensitive application configuration.

- `secret.yaml`  
  Stores sensitive values such as application keys and credentials.

- `deployment-phpfpm.yaml`  
  Deployment running the Laravel application using PHP FPM.

- `deployment-worker.yaml`  
  Deployment running background workers using the command  
  `php artisan queue:work`.

- `service.yaml`  
  Internal Kubernetes service exposing PHP FPM pods.

- `ingress.yaml`  
  External access configuration using Kubernetes Ingress.

- `hpa-phpfpm.yaml`  
  Horizontal Pod Autoscaler for the PHP FPM deployment.

- `hpa-worker.yaml`  
  Horizontal Pod Autoscaler for the worker deployment.

---

## Terraform Infrastructure Structure

Terraform code is located in `laravel-10-boilerplate-infra-task` and is organized using reusable modules and environment specific configurations.

---

### environments/

Each environment contains its own Terraform configuration and variables.

- `dev/`  
  Development environment configuration.

- `staging/`  
  Staging environment configuration.

- `production/`  
  Production environment configuration.

This structure provides isolated Terraform state, controlled promotion between environments, and safe separation of resources.

---

### modules/

Reusable Terraform modules shared across all environments.

- `vpc/`  
  Creates the VPC, public and private subnets, route tables, Internet Gateway, and NAT Gateways.

- `security-group/`  
  Defines security groups and network access rules.

- `eks/`  
  Provisions the Amazon EKS cluster and managed node groups.

- `rds/`  
  Provisions the relational database infrastructure.

The root environment configurations wire these modules together by passing outputs such as VPC IDs, subnet IDs, and security group IDs between modules.

---

## How to Deploy Infrastructure

To deploy the development environment:

```bash
cd laravel-10-boilerplate-infra-task/environments/dev
terraform init
terraform plan
terraform apply


## Local Development Setup

### Clone Repository


git clone https://gitlab.com/Emmylong1/laravel-10-boilerplate-task.git
cd laravel-10-boilerplate-task

The goal of this project is to serve as a boilerplate for Laravel 10
utilizing light-weight alpine linux images for nginx and php 8.2 (fpm)



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
#