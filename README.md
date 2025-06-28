**Inception Project - Dockerized Deployment of Nginx, WordPress, and MariaDB
Overview**
The Inception project aims to demonstrate container orchestration and microservices deployment by running a fully functional WordPress website stack using Docker containers. The stack consists of the following components:

Nginx as a reverse proxy and web server

WordPress as the content management system (CMS)

MariaDB as the relational database backend

This review covers the steps taken to containerize, install, configure, and connect these services efficiently within a Docker environment.

Docker Usage and Architecture
The project leverages Docker for containerization, isolating each service into its own container to ensure modularity, scalability, and easy maintenance.

Docker Images: Official images from Docker Hub were used for Nginx, WordPress, and MariaDB, reducing build complexity.

Docker Compose: Utilized to orchestrate multi-container setup, defining services, networks, and volumes in a declarative YAML format.

Volumes: Persistent volumes were configured for MariaDB to maintain data durability across container restarts, and for WordPress to save user uploads.

Networks: A custom Docker network was created to allow seamless inter-container communication, ensuring the WordPress container can communicate with MariaDB and Nginx.

Component Installation and Configuration
MariaDB
Installation: Deployed using the official mariadb Docker image.

Configuration:

Environment variables set for root password, database name, and user credentials.

Data directory mapped to a Docker volume to persist data.

Exposed internal port 3306 (no external exposure to enhance security).

Security: MySQL/MariaDB secure installation practices applied via environment configuration (disabling remote root access, strong passwords).

WordPress
Installation: Used the official wordpress Docker image, which includes PHP and Apache.

Configuration:

Environment variables set to connect to MariaDB database (database name, user, password, host).

Port 80 inside the container mapped to a custom port on the host for accessibility.

Volume mapped to persist WordPress uploads and plugins.

Dependencies: PHP extensions required by WordPress (mysqli, gd, curl, mbstring, etc.) come pre-installed in the official image.

Nginx
Installation: Utilized the official nginx Docker image.

Configuration:

Configured as a reverse proxy to forward HTTP(S) requests to WordPress.

Custom Nginx configuration file mounted as a volume inside the container.

SSL support (optional) configured via mounted certificates.

Static file caching and gzip compression enabled for performance.

Ports: Nginx listens on standard HTTP/HTTPS ports (80 and 443), mapped to the host machine.

Networking and Interconnection
Containers were connected using a user-defined Docker bridge network, allowing hostname-based service discovery (mariadb, wordpress, nginx).

Nginx proxies requests to WordPress via the container name and internal port.

WordPress connects to MariaDB via the network alias defined in Docker Compose.

Challenges and Solutions
Database Initialization Delay: WordPress container attempts to connect before MariaDB is ready. Solved by adding retry logic or depends_on in Docker Compose.

File Permissions: WordPress upload directories required proper permission adjustments within containers to allow file writes.

Nginx Configuration: Needed fine-tuning for proxy headers and handling PHP-specific rewrites.

Summary
The Inception project effectively demonstrates a modern containerized web stack with a clear separation of concerns and easy scalability. Using Docker and Docker Compose simplifies deployment, while Nginx serves as a flexible front-facing proxy, optimizing traffic routing and security.

This architecture offers an excellent foundation for further extension, such as adding caching layers (Redis, Memcached), SSL certificate automation, or scaling WordPress instances horizontally behind a load balancer.

