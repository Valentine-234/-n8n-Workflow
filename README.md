**Name:**  Ifechukwu Valentine Achebe
**Email:** iamachebe@gmail.com

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

## Repository Structure

```test
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
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── terraform.tfvars
│   │   ├── staging/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── terraform.tfvars
│   │   └── production/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── terraform.tfvars
│   │
│   └── modules/
│       ├── vpc/
│       ├── security-group/
│       ├── eks/
│       ├── rds/
│       └── ecr/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
│
└── README.md
```

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
  Staging environment con

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
```

## CI/CD Workflow Overview

This project uses GitLab CI/CD to automate testing, container image building, and application deployment.  
The pipeline is designed to enforce quality gates and support multiple environments in a controlled promotion flow.

---

## Pipeline Stages

The CI/CD pipeline consists of three stages:

---

### Test Stage

The test stage is responsible for validating the application before any code is merged.

- Runs only when a merge request is opened
- Triggered specifically for merge requests targeting the `main` branch
- Uses Docker and Docker Compose to run the application test stack
- Fails fast if required files such as `docker-compose.yml` are missing
- Executes application tests inside containers
- Blocks the merge request if any test fails

This ensures broken or untested code never enters shared branches.

---

### Build Stage

The build stage runs after a successful merge.

- Triggered after merge into `development`, `staging`, or `main` branches
- Builds the application Docker image using the provided Dockerfile
- Uses Docker in Docker for image building
- Tags the image based on the target environment
- Pushes the image to a container registry such as DockerHub or AWS ECR

This stage produces immutable container images used for deployment.

---

### Deploy Stage

The deploy stage is responsible for releasing the application to Kubernetes.

- Uses Helm to deploy the application
- Integrates directly with the Helm chart defined in this repository
- Deployment behavior is controlled by the target branch

---

## Environment Integration

The CI/CD workflow integrates with multiple environments using branch based deployment.

---

### Development Environment

- Branch: `development`
- Deployment: Automatic
- Purpose: Active development and testing
- Uses Helm with development specific configuration values

---

### Staging Environment

- Branch: `staging`
- Deployment: Automatic
- Purpose: Pre production validation
- Closely mirrors production configuration

---

### Production Environment

- Branch: `main` or `master`
- Deployment: Manual approval required
- Purpose: Production release
- Enforces an additional safety gate before deployment

---

## Deployment Strategy

- Tests run before any merge is allowed
- Builds occur only after successful merges
- Deployments are environment aware and branch controlled
- Helm dry run can be used in CI to validate Kubernetes manifests without requiring a live cluster

This workflow ensures consistent, repeatable, and safe deployments across all environments.


## Required Commands to Run the Project

This section outlines the common commands required to run, test, and deploy the project across local and infrastructure environments.

---

## Local Development

Clone the repository and move into the project directory:

```bash
git clone https://gitlab.com/Emmylong1/laravel-10-boilerplate-task.git
cd laravel-10-boilerplate-task
```

## Infrastructure Deployment with Terraform

Navigate to the desired environment directory:
```bash
cd laravel-10-boilerplate-infra-task/environments/dev
```

Initialize Terraform and deploy infrastructure:
```bash
terraform init
terraform plan
terraform apply
```

Repeat the same process for the staging or production environment directories as needed.


## Application Deployment with Helm

Validate the Helm chart locally:
```bash
helm lint ./helm-chart/laravel-app
helm template laravel-app ./helm-chart/laravel-app
```

Deploy or upgrade the application:
```bash
helm upgrade --install laravel-10-boilerplate-task ./helm-chart/laravel-app \
  --namespace prod-laravel-10-boilerplate-task \
  --create-namespace
  ```

## CI/CD Execution

- CI/CD pipelines are triggered automatically through GitLab.

- Tests run on merge requests

- Builds run after successful merges

- Deployments are executed per environment based on branch

- Production deployments require manual approval

Helm dry run is used in CI environments when a live Kubernetes cluster is not available


## Local Development Setup

This project supports local development using Docker and Docker Compose.
All application services including PHP FPM, Nginx, MySQL, Redis, and background workers are orchestrated via `docker-compose.yml`.

![Docker-compose-setup](docs/WhatsApp Image 2025-12-30 at 07.45.51.jpeg)


### Prerequisites

Ensure the following tools are installed on your machine:

- Docker

- Docker Compose v2

- Git

Verify installation:
```bash
docker --version
docker compose version
```

## Environment Configuration

Copy the example environment file and update values as needed:

```bash
cp .env.example .env
```

## Minimum Required Values for Local Development
```bash
APP_ENV=local
APP_DEBUG=true
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=secret

MYSQL_ROOT_PASSWORD=secret

REDIS_HOST=redis
CACHE_DRIVER=redis
QUEUE_CONNECTION=redis
SESSION_DRIVER=redis
```
## Start Local Services

Build and start all required services:
```bash 
docker compose up -d --build
```


## This will start the following containers:
```bash 
ap-app
Laravel application running PHP FPM

ap-nginx
Nginx web server

ap-mysql
MySQL database

ap-redis
Redis cache and queue backend

ap-worker-local
Laravel queue workers
```
## Verify running containers:
```bash
docker ps
```
## Application Setup

Run the following commands inside the application container:

```bash
docker compose exec app composer install
docker compose exec app php artisan key:generate
docker compose exec app php artisan migrate
```
## Optional Seed Data
```bash
docker compose exec app php artisan db:seed
```

## Access the Application

Application URL:
```bash
http://localhost:8022
```

## Service ports:

- MySQL exposed port: 3306

- Redis exposed port: 6379

- Ports can be adjusted using values in the .env file.

## Running Tests Locally

Execute the test suite inside the container:

- docker compose exec app php artisan test

- Stopping the Environment

## Stop all services:
```bash
docker compose down
```

## Remove containers, networks, and volumes for a clean reset:
```bash
docker compose down -v
```
## Notes on docker-compose.yml

- The docker-compose.yml file is intended for local development only

- MySQL requires MYSQL_ROOT_PASSWORD to be set

- Redis uses a custom configuration for performance tuning

- PHP runs under Supervisor for process management

- Nginx proxies HTTP requests to PHP FPM


## Optional Improvements

### Improving Dockerfile Security

The current Dockerfile is suitable for building and running the application image, but production systems benefit from additional hardening. The following improvements are recommended best practices.

#### Run as a non root user
Create and use a dedicated user inside the container. Avoid running PHP FPM or workers as root.

```dockerfile
RUN addgroup -g 10001 app && adduser -D -G app -u 10001 app
USER app
```


### Use minimal base images

Prefer minimal images such as Alpine, or consider distroless for runtime layers to reduce the attack surface.

#### Examples
Alpine for runtime
Distroless for runtime only if your app does not require a shell or package manager at runtime

### Use multi stage builds

Ensure build tools and compilers do not exist in the final image. Keep the final image runtime only.

Recommended pattern
Builder stage installs dependencies and builds assets
Runtime stage only copies built artifacts

### Pin package and dependency versions

Avoid pulling floating latest packages. Pin Alpine packages or OS dependencies where possible to reduce supply chain uncertainty.

### Reduce permissions and harden filesystem

Make the root filesystem read only where possible. Write only to required directories like storage and cache.

Kubernetes also helps enforce this using securityContext, but container defaults matter.

### Drop Linux capabilities

If you use Kubernetes, drop capabilities in the Pod securityContext. If you run Docker directly, use reduced capabilities.

Kubernetes example
```bash
securityContext:
  allowPrivilegeEscalation: false
  readOnlyRootFilesystem: true
  capabilities:
    drop:
      - ALL
```
### Add a healthcheck

Healthchecks help detect runtime failure early and allow orchestration platforms to self heal.
```bash
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s \
  CMD php -v >/dev/null || exit 1
```
### Enable image vulnerability scanning

Enable scanning in your registry and in CI.

DockerHub can scan images depending on plan
AWS ECR supports scanning
In GitLab CI, use Trivy or Grype to fail builds on critical vulnerabilities

Trivy example
```bash
trivy image --exit-code 1 --severity HIGH,CRITICAL "$IMAGE"
```
### Avoid leaking secrets during build

Never bake secrets into images. Avoid passing secrets using ARG in Dockerfile. Use runtime injection via Kubernetes Secrets, Vault, or GitLab masked variables.

### Use explicit COPY paths and a strong .dockerignore

Prevent accidental inclusion of secrets and large dev files.

```bash
Recommended in .dockerignore
.env
.git
node_modules
vendor
storage
tests output artifacts
```
### Alternative Kubernetes Deployment Without Helm

This repository can be deployed without Helm by using either plain Kubernetes manifests or Kustomize overlays. This is useful when you want minimal templating and stronger GitOps workflows.

Two recommended approaches are described below, including ArgoCD integration.

### Option A: Plain Kubernetes Manifests

Create a directory such as k8s/ containing static YAML resources.

Example directory layout
```bash
k8s/
  namespace.yaml
  configmap.yaml
  secret.yaml
  deployment-phpfpm.yaml
  deployment-worker.yaml
  service.yaml
  ingress.yaml
  hpa-phpfpm.yaml
  hpa-worker.yaml
```

Deploy with kubectl
```bash
kubectl apply -f k8s/
```

Pros
Simple and explicit
No templating
Good for small projects

Cons
Harder to manage environment differences without duplication

### Option B: Kustomize Overlays

Kustomize allows a base configuration plus per environment overlays without templating.

Recommended directory layout
```bash
k8s/
  base/
    kustomization.yaml
    configmap.yaml
    secret.yaml
    deployment-phpfpm.yaml
    deployment-worker.yaml
    service.yaml
    ingress.yaml
  overlays/
    development/
      kustomization.yaml
      patch.yaml
    staging/
      kustomization.yaml
      patch.yaml
    production/
      kustomization.yaml
      patch.yaml
      hpa.yaml
```

Deploy production overlay
```bash
kubectl apply -k k8s/overlays/production
```


Pros
Environment differences are clean and minimal
No Helm templating
Native support in kubectl
Very GitOps friendly

Cons
Complex logic is not as flexible as Helm

## GitOps Deployment Using ArgoCD

ArgoCD continuously syncs Kubernetes state from Git, enabling safe, auditable deployments. This works with both plain manifests and Kustomize.

 ### Install ArgoCD
 ```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Expose the ArgoCD server locally
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Get initial admin password
```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo
```
### ArgoCD Application for Kustomize Deployment

Create argocd/application-production.yaml
```bash
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: laravel-app-production
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://gitlab.com/YOUR_NAMESPACE/YOUR_REPO.git
    targetRevision: main
    path: k8s/overlays/production
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

Apply it
```bash
kubectl apply -f argocd/application-production.yaml
```
### ArgoCD Application for Plain Manifests

If you deploy from k8s/ directly, set the path to that directory.
```bash
source:
  repoURL: https://gitlab.com/YOUR_NAMESPACE/YOUR_REPO.git
  targetRevision: main
  path: k8s
  ```

### Recommended GitOps Workflow

Development branch syncs to development namespace
Staging branch syncs to staging namespace
Main branch syncs to production namespace

Production sync can be automated or manual depending on risk tolerance.

Recommended production policy
Automated sync disabled
Manual sync required to add a safety gate

Example syncPolicy for manual production
```bash
syncPolicy:
  syncOptions:
    - CreateNamespace=true
```
### Summary

Docker hardening focuses on reducing privilege, reducing attack surface, preventing secret leakage, and improving runtime safety.

Non Helm deployment can be achieved using plain Kubernetes YAML or Kustomize overlays.

ArgoCD provides GitOps based continuous deployment for both approaches with auditability, drift correction, and consistent environment promotion.