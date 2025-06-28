<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Inception Project Technical Review</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Source+Code+Pro:wght@400;500&display=swap');

  /* Root colors and variables */
  :root {
    --color-bg: #121212;
    --color-surface: #1e1e1e;
    --color-surface-light: #2a2a2a;
    --color-primary: #4fc3f7;
    --color-primary-dark: #3ab4e6;
    --color-secondary: #81d4fa;
    --color-text: #e0e0e0;
    --color-text-light: #f5f5f5;
    --color-text-muted: #b0b0b0;
    --color-accent: #ffca28;
    --color-accent-dark: #ffb300;
    --color-shadow: rgba(0,0,0,0.7);
    --border-radius: 8px;
    --transition: all 0.3s ease;
  }

  /* Reset & base */
  * {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }
  
  body {
    margin: 0;
    font-family: 'Inter', sans-serif;
    background: var(--color-bg);
    color: var(--color-text);
    line-height: 1.7;
    padding: 2rem 1rem;
    max-width: 900px;
    margin-left: auto;
    margin-right: auto;
  }
  
  h1, h2, h3, h4 {
    font-weight: 600;
    margin-bottom: 0.6em;
    line-height: 1.3;
  }
  
  h1 {
    color: var(--color-primary);
    font-size: 2.5rem;
    border-bottom: 3px solid var(--color-accent);
    padding-bottom: 0.5rem;
    margin-bottom: 1.5rem;
    animation: fadeInDown 0.7s ease forwards;
    position: relative;
  }
  
  h1::after {
    content: '';
    position: absolute;
    bottom: -3px;
    left: 0;
    width: 100px;
    height: 3px;
    background: var(--color-primary);
  }
  
  h2 {
    color: var(--color-primary);
    font-size: 1.8rem;
    margin-top: 2.5rem;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 1px solid var(--color-surface-light);
    animation: fadeInLeft 0.7s ease forwards;
  }
  
  h3 {
    color: var(--color-secondary);
    font-size: 1.4rem;
    margin-top: 1.8rem;
    margin-bottom: 0.8rem;
    animation: fadeInRight 0.7s ease forwards;
  }
  
  p {
    font-size: 1.05rem;
    margin-bottom: 1.5rem;
    color: var(--color-text-light);
    animation: fadeIn 0.7s ease forwards;
  }
  
  ul, ol {
    margin-bottom: 1.8rem;
    padding-left: 1.8rem;
    animation: fadeIn 0.7s ease forwards;
  }
  
  ul {
    list-style-type: none;
  }
  
  ul li {
    position: relative;
    padding-left: 1.5rem;
    margin-bottom: 0.7rem;
    color: var(--color-text-light);
  }
  
  ul li::before {
    content: '•';
    color: var(--color-accent);
    font-size: 1.2rem;
    position: absolute;
    left: 0;
    top: -0.1rem;
  }
  
  ul ul, ul ol, ol ul, ol ol {
    margin-top: 0.5rem;
    margin-bottom: 0.5rem;
  }
  
  strong {
    color: var(--color-primary);
    font-weight: 500;
  }

  /* Container card style */
  .card {
    background: var(--color-surface);
    padding: 2.5rem;
    border-radius: var(--border-radius);
    box-shadow: 0 10px 30px var(--color-shadow);
    margin-bottom: 3rem;
    animation: fadeInUp 0.8s ease forwards;
    transition: var(--transition);
    border-left: 4px solid var(--color-primary);
  }
  
  .card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.8);
  }

  /* Code style */
  code {
    font-family: 'Source Code Pro', monospace;
    background: rgba(79, 195, 247, 0.1);
    padding: 0.2em 0.4em;
    border-radius: 4px;
    color: var(--color-accent);
    font-size: 0.9em;
    border: 1px solid rgba(79, 195, 247, 0.2);
  }
  
  pre {
    background: #1a2b3c;
    padding: 1rem;
    border-radius: var(--border-radius);
    overflow-x: auto;
    margin: 1.5rem 0;
    font-family: 'Source Code Pro', monospace;
    font-size: 0.9rem;
    line-height: 1.5;
    color: #e0e0e0;
    border-left: 4px solid var(--color-accent);
  }
  
  pre code {
    background: transparent;
    padding: 0;
    border: none;
    color: inherit;
    font-size: inherit;
  }

  /* Links */
  a {
    color: var(--color-secondary);
    text-decoration: none;
    transition: var(--transition);
  }
  
  a:hover {
    color: var(--color-primary);
    text-decoration: underline;
  }

  /* Animations */
  @keyframes fadeIn {
    from {opacity: 0;}
    to {opacity: 1;}
  }
  
  @keyframes fadeInUp {
    from {opacity: 0; transform: translateY(20px);}
    to {opacity: 1; transform: translateY(0);}
  }
  
  @keyframes fadeInDown {
    from {opacity: 0; transform: translateY(-20px);}
    to {opacity: 1; transform: translateY(0);}
  }
  
  @keyframes fadeInLeft {
    from {opacity: 0; transform: translateX(-20px);}
    to {opacity: 1; transform: translateX(0);}
  }
  
  @keyframes fadeInRight {
    from {opacity: 0; transform: translateX(20px);}
    to {opacity: 1; transform: translateX(0);}
  }

  /* Responsive */
  @media (max-width: 768px) {
    body {
      padding: 1.5rem 1rem;
    }
    
    .card {
      padding: 1.8rem;
    }
    
    h1 {
      font-size: 2.2rem;
    }
    
    h2 {
      font-size: 1.6rem;
    }
    
    h3 {
      font-size: 1.3rem;
    }
  }
  
  @media (max-width: 480px) {
    body {
      padding: 1.2rem 0.8rem;
    }
    
    .card {
      padding: 1.5rem;
    }
    
    h1 {
      font-size: 1.8rem;
    }
    
    h2 {
      font-size: 1.4rem;
    }
  }
</style>
</head>
<body>

  <h1>Inception Project - Dockerized Deployment of Nginx, WordPress, and MariaDB</h1>

  <div class="card">
    <h2>Overview</h2>
    <p>The Inception project demonstrates container orchestration and microservices deployment by running a fully functional WordPress website stack using Docker containers. The stack consists of the following components:</p>
    <ul>
      <li><strong>Nginx</strong> as a reverse proxy and web server</li>
      <li><strong>WordPress</strong> as the content management system (CMS)</li>
      <li><strong>MariaDB</strong> as the relational database backend</li>
    </ul>
    <p>This review covers the steps taken to containerize, install, configure, and connect these services efficiently within a Docker environment.</p>
  </div>

  <div class="card">
    <h2>Docker Usage and Architecture</h2>
    <p>The project leverages Docker for containerization, isolating each service into its own container to ensure modularity, scalability, and easy maintenance.</p>
    <ul>
      <li><strong>Docker Images:</strong> Official images from Docker Hub were used for Nginx, WordPress, and MariaDB, reducing build complexity.</li>
      <li><strong>Docker Compose:</strong> Utilized to orchestrate multi-container setup, defining services, networks, and volumes in a declarative YAML format.</li>
      <li><strong>Volumes:</strong> Persistent volumes were configured for MariaDB to maintain data durability across container restarts, and for WordPress to save user uploads.</li>
      <li><strong>Networks:</strong> A custom Docker network was created to allow seamless inter-container communication, ensuring the WordPress container can communicate with MariaDB and Nginx.</li>
    </ul>
    
    <pre><code>version: '3.8'

services:
  nginx:
    image: nginx:latest
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./certs:/etc/nginx/certs
    depends_on:
      - wordpress
    networks:
      - app-network

  wordpress:
    image: wordpress:latest
    volumes:
      - wordpress:/var/www/html
    environment:
      WORDPRESS_DB_HOST: mariadb
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: wppassword
      WORDPRESS_DB_NAME: wpdb
    networks:
      - app-network

  mariadb:
    image: mariadb:latest
    volumes:
      - db_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wpdb
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: wppassword
    networks:
      - app-network

volumes:
  wordpress:
  db_data:

networks:
  app-network:
    driver: bridge</code></pre>
  </div>

  <div class="card">
    <h2>Component Installation and Configuration</h2>

    <h3>MariaDB</h3>
    <ul>
      <li><strong>Installation:</strong> Deployed using the official <code>mariadb</code> Docker image.</li>
      <li><strong>Configuration:</strong>
        <ul>
          <li>Environment variables set for root password, database name, and user credentials.</li>
          <li>Data directory mapped to a Docker volume to persist data.</li>
          <li>Exposed internal port 3306 (no external exposure to enhance security).</li>
        </ul>
      </li>
      <li><strong>Security:</strong> MySQL/MariaDB secure installation practices applied via environment configuration (disabling remote root access, strong passwords).</li>
    </ul>

    <h3>WordPress</h3>
    <ul>
      <li><strong>Installation:</strong> Used the official <code>wordpress</code> Docker image, which includes PHP and Apache.</li>
      <li><strong>Configuration:</strong>
        <ul>
          <li>Environment v
