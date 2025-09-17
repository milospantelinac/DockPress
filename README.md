<p align="center">
  <img 
    src="https://github.com/user-attachments/assets/1bbee46f-1ec4-4016-b3c3-41b27aa59860" 
    alt="DockPress Logo" 
    width="300" />
</p>

# 🚀 DockPress

> 🐳 A modern **Dockerized WordPress starter kit** with Nginx, MySQL, PHP-FPM, Redis, Mailhog, phpMyAdmin, WP-CLI, and optional Xdebug.

<p align="center">
  <img src="https://img.shields.io/badge/Docker-Compose-blue?logo=docker" alt="Docker Compose Badge"/>
  <img src="https://img.shields.io/badge/WordPress-6.8+-blue?logo=wordpress" alt="WordPress Badge"/>
  <img src="https://img.shields.io/badge/PHP-8.2+-777BB4?logo=php" alt="PHP Badge"/>
  <img src="https://img.shields.io/badge/MySQL-8.4+-4479A1?logo=mysql" alt="MySQL Badge"/>
</p>

<p align="center">
  Develop locally like in production.  
  Speed up your workflow, remove “works on my machine” issues, and ship faster. 🚀
</p>

---

## ✨ Features

- ⚡ **One command up**: `docker compose -f compose.{ENV}.yml up`
- 📝 **WP-CLI** included for easy management
- 🐘 **PHP-FPM 8.2** with Xdebug (dev only)
- 🗄️ **MySQL 8.4** with phpMyAdmin
- 🗃️ **Redis** for object caching
- 📬 **Mailhog** for local email testing
- 🔐 Safe defaults for **prod** (OPcache, DISALLOW_FILE_EDIT, tuned configs)
- 🪟 Optimized for **Windows/WSL2** (named volume for WP core, bind-mount only `wp-content`)

---

## 📂 Project Structure

```
dockpress/
├── docker/
│   ├── nginx.conf
│   ├── php.ini
│   ├── Dockerfile.dev
│   ├── Dockerfile.prod
├── src/
│   └── wp-content/      # themes, plugins, uploads
├── compose.dev.yml
├── compose.prod.yml
├── .env
└── README.md
```

---

## ⚙️ Requirements

- Docker Desktop (Compose v2+)
- macOS / Linux / Windows 11 (WSL2 highly recommended)
- ~4 GB RAM free for containers

---

## 🚀 Quick Start (Development)

1. **Clone repo**
   ```bash
   git clone https://github.com/<you>/dockpress.git
   cd dockpress
   ```

2. **Setup `.env`**
   ```dotenv
   DB_NAME=wp
   DB_USER=wp
   DB_PASSWORD=wp
   DB_ROOT_PASSWORD=root
   WP_ENV=development
   WP_DEBUG=true
   WP_REDIS_HOST=redis
   ```

3. **Create `wp-content` folder**
   ```bash
   mkdir -p src/wp-content
   ```

4. **Initialize WordPress Core (choose your OS)**

   <p>
     <img src="https://img.shields.io/badge/Windows-PowerShell-0078D4?logo=windows&logoColor=white" alt="Windows" />
     <img src="https://img.shields.io/badge/Linux-Bash-000000?logo=linux&logoColor=white" alt="Linux" />
     <img src="https://img.shields.io/badge/macOS-Bash-000000?logo=apple&logoColor=white" alt="macOS" />
   </p>

   - **Windows (PowerShell)**  
     ```powershell
     # (optional) allow running local scripts in this session
     Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

     # prefill (volume defaults to dockpress_wp_core)
     .\scripts\prefill-wp-core.ps1
     # or specify volume/image explicitly
     .\scripts\prefill-wp-core.ps1 -Volume dockpress_wp_core -Image wordpress:6.8.2-php8.2-fpm
     ```

   - **Linux/macOS (Bash)**  
     ```bash
     bash scripts/prefill-wp-core.sh           # uses dockpress_wp_core by default
     # or specify volume and image
     bash scripts/prefill-wp-core.sh dockpress_wp_core wordpress:6.8.2-php8.2-fpm
     ```

5. **Start stack**
   ```bash
   docker compose -f compose.{ENV}.yml up -d
   ```

6. **Access services**
   | Service      | URL                    |
   |--------------|------------------------|
   | WordPress    | http://localhost:8080  |
   | phpMyAdmin   | http://localhost:8081  |
   | Mailhog      | http://localhost:8025  |

---

## 🧰 Useful Commands

- **Check logs**
  ```bash
  docker compose -f compose.{ENV}.yml logs -f wordpress
  ```
- **Run WP-CLI**
  ```bash
  docker compose exec wordpress wp plugin list
  ```
- **Open shell**
  ```bash
  docker compose exec wordpress bash
  ```

---

## 🐞 Xdebug (Dev)

- Enabled in `docker/Dockerfile.dev`
- Default port: `9003`
- Example VS Code config (`.vscode/launch.json`):

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Listen for Xdebug",
      "type": "php",
      "request": "launch",
      "port": 9003,
      "pathMappings": {
        "/var/www/html/wp-content": "${workspaceFolder}/src/wp-content"
      }
    }
  ]
}
```

---

## 🏭 Production

- Use `compose.prod.yml` + `docker/Dockerfile.prod`
- Differences from dev:
  - No Xdebug
  - OPcache tuned for production
  - DISALLOW_FILE_EDIT enabled
  - Secrets should be strong and stored securely
- Deploy with:
  ```bash
  docker compose -f compose.prod.yml up -d
  ```

---

## 📊 Services Overview

| Service    | Image                        | Ports        | Purpose               |
|------------|------------------------------|--------------|-----------------------|
| WordPress  | wordpress:6.8.2-php8.2-fpm   | 8080         | App core              |
| Nginx      | nginx:1.27-alpine            | 8080 → 80    | Reverse proxy         |
| MySQL      | mysql:8.4                    | 3307 → 3306  | Database              |
| phpMyAdmin | phpmyadmin:5                 | 8081         | DB UI                 |
| Redis      | redis:7-alpine               | 6379         | Object cache          |
| Mailhog    | mailhog/mailhog              | 8025         | Email catcher         |

---

## 🔒 Security Notes

- Always use strong DB passwords in production
- Run behind HTTPS (Traefik, Caddy, or Nginx proxy with SSL)
- Regular backups (DB + `wp-content`)
- Avoid committing secrets (`.env`) to Git

---

## 🤝 Contributing

1. Fork this repo
2. Create a feature branch (`git checkout -b feature/new-stuff`)
3. Commit changes (`git commit -m "Add new stuff"`)
4. Push branch (`git push origin feature/new-stuff`)
5. Create Pull Request 🚀

---

## 📜 License

MIT — free to use, modify, and share.

---

<p align="center">
  Made with ❤️ by Milos Pantelinac, for developers.  
  Happy hacking! 🐳
</p>