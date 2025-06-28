<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Inception Project Technical Review</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap');

  /* Root colors and variables */
  :root {
    --color-bg: #121212;
    --color-primary: #4fc3f7;
    --color-secondary: #81d4fa;
    --color-text: #e0e0e0;
    --color-accent: #ffca28;
    --color-shadow: rgba(0,0,0,0.7);
  }

  /* Reset & base */
  * {
    box-sizing: border-box;
  }
  body {
    margin: 0;
    font-family: 'Inter', sans-serif;
    background: var(--color-bg);
    color: var(--color-text);
    line-height: 1.6;
    padding: 2rem 1rem;
    max-width: 900px;
    margin-left: auto;
    margin-right: auto;
  }
  h1, h2, h3 {
    color: var(--color-primary);
    margin-bottom: 0.4em;
  }
  h1 {
    font-size: 2.5rem;
    font-weight: 700;
    border-bottom: 3px solid var(--color-accent);
    padding-bottom: 0.3em;
    margin-bottom: 1rem;
    animation: fadeInDown 0.7s ease forwards;
  }
  h2 {
    font-size: 1.8rem;
    margin-top: 2rem;
    animation: fadeInLeft 0.7s ease forwards;
  }
  h3 {
    font-size: 1.3rem;
    margin-top: 1.5rem;
    color: var(--color-secondary);
    animation: fadeInRight 0.7s ease forwards;
  }
  p, ul {
    font-size: 1rem;
    margin-bottom: 1rem;
    color: var(--color-text);
    animation: fadeIn 0.7s ease forwards;
  }
  ul {
    padding-left: 1.5rem;
    list-style-type: disc;
  }

  /* Container card style */
  .card {
    background: #1e1e1e;
    padding: 2rem;
    border-radius: 12px;
    box-shadow: 0 10px 30px var(--color-shadow);
    margin-bottom: 3rem;
    animation: fadeInUp 0.8s ease forwards;
  }

  /* Code style (optional) */
  code {
    background: #263238;
    padding: 0.2em 0.4em;
    border-radius: 4px;
    font-family: 'Source Code Pro', monospace;
    color: var(--color-accent);
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
  @media (max-width: 600px) {
    body {
      padding: 1rem;
      max-width: 100%;
    }
    h1 {
      font-size: 2rem;
    }
    h2 {
      font-size: 1.5rem;
    }
  }
</style>
</head>
<body>

  <h1>Inception Project - Dockerized Deployment of Nginx, WordPress, and MariaDB</h1>

  <div class="card">
    <h2>Overview</h2>
    <p>The Inception project aims to demonstrate container orchestration and microservices deployment by running a fully functional WordPress website stack using Docker containers. The stack consists of the following components:</p>
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
          <li>Environment variables set to connect to MariaDB database (database name, user, password, host).</li>
          <li>Port 80 inside the container mapped to a custom port on the host for accessibility.</li>
          <li>Volume mapped to persist WordPress uploads and plugins.</li>
        </ul>
      </li>
      <li><strong>Dependencies:</strong> PHP extensions required by WordPress (<code>mysqli</code>, <code>gd</code>, <code>curl</code>, <code>mbstring</code>, etc.) come pre-installed in the official image.</li>
    </ul>

    <h3>Nginx</h3>
    <ul>
      <li><strong>Installation:</strong> Utilized the official <code>nginx</code> Docker image.</li>
      <li><strong>Configuration:</strong>
        <ul>
          <li>Configured as a reverse proxy to forward HTTP(S) requests to WordPress.</li>
          <li>Custom Nginx configuration file mounted as a volume inside the container.</li>
          <li>SSL support (optional) configured via mounted certificates.</li>
          <li>Static file caching and gzip compression enabled for performance.</li>
        </ul>
      </li>
      <li><strong>Ports:</strong> Nginx listens on standard HTTP/HTTPS ports (80 and 443), mapped to the host machine.</li>
    </ul>
  </div>

  <div class="card">
    <h2>Networking and Interconnection</h2>
    <p>Containers were connected using a user-defined Docker bridge network, allowing hostname-based service discovery (<code>mariadb</code>, <code>wordpress</code>, <code>nginx</code>).</p>
    <p>Nginx proxies requests to WordPress via the container name and internal port.</p>
    <p>WordPress connects to MariaDB via the network alias defined in Docker Compose.</p>
  </div>

  <div class="card">
    <h2>Challenges and Solutions</h2>
    <ul>
      <li><strong>Database Initialization Delay:</strong> WordPress container attempts to connect before MariaDB is ready. Solved by adding retry logic or <code>depends_on</code> in Docker Compose.</li>
      <li><strong>File Permissions:</strong> WordPress upload directories required proper permission adjustments within containers to allow file writes.</li>
      <li><strong>Nginx Configuration:</strong> Needed fine-tuning for proxy headers and handling PHP-specific rewrites.</li>
    </ul>
  </div>

  <div class="card">
    <h2>Summary</h2>
    <p>The Inception project effectively demonstrates a modern containerized web stack with a clear separation of concerns and easy scalability. Using Docker and Docker Compose simplifies deployment, while Nginx serves as a flexible front-facing proxy, optimizing traffic routing and security.</p>
    <p>This architecture offers an excellent foundation for further extension, such as adding caching layers (Redis, Memcached), SSL certificate automation, or scaling WordPress instances horizontally behind a load balancer.</p>
  </div>

</body>
</html>
