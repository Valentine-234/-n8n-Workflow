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
