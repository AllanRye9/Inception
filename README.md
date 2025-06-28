# 🐋 Inception Project - Dockerized Web Stack

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-%23117AC9.svg?style=for-the-badge&logo=WordPress&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)

A containerized deployment of Nginx, WordPress, and MariaDB using Docker Compose, demonstrating modern container orchestration techniques.

## 🌟 Features

- **Full isolation** of services in separate containers
- **Persistent storage** for database and WordPress content
- **Custom network** for secure inter-container communication
- **Optimized Nginx** configuration as reverse proxy
- **Easy deployment** with single-command setup

## 🏗️ Architecture

```mermaid
graph LR
    A[Client] --> B[Nginx:80]
    B --> C[WordPress:80]
    C --> D[MariaDB:3306]
    D -->|Persistent| E[(Database Volume)]
    C -->|Persistent| F[(WordPress Volume)]
