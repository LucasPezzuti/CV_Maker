# CV Torta - Aplicación de Gestión de Currículum Vitae

![GitHub](https://img.shields.io/badge/license-MIT-blue.svg)
![GitHub top language](https://img.shields.io/badge/frontend-Vue%203%2FNuxt%204-green.svg)
![GitHub top language](https://img.shields.io/badge/backend-Laravel%2012-red.svg)
![Database](https://img.shields.io/badge/database-MySQL%208.4-blue.svg)

## 📋 Tabla de Contenidos

- [Descripcion del Proyecto](#descripcion-del-proyecto)
- [Caracteristicas](#caracteristicas)
- [Stack Tecnologico](#stack-tecnologico)
- [Requisitos Previos](#requisitos-previos)
- [Instalacion](#instalacion)
- [Configuracion](#configuracion)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [API Endpoints](#api-endpoints)
- [Base de Datos](#base-de-datos)
- [Desarrollo](#desarrollo)
- [Autenticacion](#autenticacion)
- [Licencia](#licencia)

---

# 📝 English Version Below

---

## 🎯 Descripcion del Proyecto

**CV Torta** es una aplicación web completa de gestión y edición de currículum vitae. Permite a los usuarios crear, editar y descargar sus currículums en formato PDF con múltiples plantillas disponibles. La aplicación cuenta con una interfaz moderna e intuitiva construida con Vue 3 y Quasar, respaldada por una API RESTful robusta en Laravel 12.

### Caracteristicas Principales

✨ **Gestion Completa de CV**

- Crear y editar perfiles profesionales
- Gestionar secciones de educacion, experiencia laboral y habilidades
- Multiples plantillas de diseño
- Descarga de CV en formato PDF

🔐 **Sistema de Autenticacion**

- Registro e inicio de sesion seguros
- Autenticacion basada en tokens (Laravel Sanctum)
- Gestion de sesiones de usuario

📱 **Interfaz Responsiva**

- Diseño mobile-first con Quasar Framework
- Interfaz intuitiva y moderna
- Iconografia con FontAwesome

📊 **Funcionalidades Adicionales**

- Calendario de eventos
- Registro de comidas (modulo integrado)
- Gestion de programas y utilidades
- Panel de usuario personalizado

---

## 🛠️ Stack Tecnologico

### Frontend

- **Nuxt 4** - Framework meta de Vue 3
- **Vue 3** - Framework progresivo de JavaScript
- **Quasar Framework** - Framework de componentes UI
- **Pinia** - Gestor de estado (con persistencia)
- **Axios** - Cliente HTTP
- **Vite** - Empaquetador y bundler
- **TypeScript** - Tipado estático
- **FontAwesome** - Librería de iconos
- **@vueuse/nuxt** - Composables reutilizables

### Backend

- **Laravel 12** - Framework web PHP
- **Laravel Sanctum** - Autenticación de API tokens
- **Eloquent ORM** - ORM para base de datos
- **PHP 8.3** - Lenguaje de programación
- **PHPUnit** - Framework de testing

### Base de Datos

- **MySQL 8.4** - Sistema de gestión de base de datos
- **Migraciones Laravel** - Control de versiones de BD

### Node & Herramientas

- **Node.js 22** - Entorno de ejecución
- **Composer** - Gestor de dependencias PHP
- **ESLint** - Linter de JavaScript/TypeScript
- **Laravel Pint** - Formateador PHP

---

## 📋 Requisitos Previos (Checklist)

Antes de comenzar, asegúrate de tener instalado:

- **PHP 8.3** o superior
- **Node.js 22** o superior
- **Composer** (gestor de dependencias de PHP)
- **npm** o **yarn** (gestor de dependencias de Node)
- **MySQL 8.4** o superior
- **Git** (para clonar el repositorio)

---

## 🚀 Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/tuusuario/cv-torta.git
cd cv-torta
```

### 2. Configurar Backend (Laravel)

```bash
cd multiapp-backend-laravel

# Instalar dependencias de PHP
composer install

# Crear archivo de configuración
cp .env.example .env

# Generar clave de aplicación
php artisan key:generate

# Crear base de datos MySQL (ejecutar en tu cliente MySQL)
# mysql> CREATE DATABASE cvtorta;
# mysql> CREATE USER 'cvtorta_user'@'localhost' IDENTIFIED BY 'tu_contraseña';
# mysql> GRANT ALL PRIVILEGES ON cvtorta.* TO 'cvtorta_user'@'localhost';
# mysql> FLUSH PRIVILEGES;

# Ejecutar migraciones
php artisan migrate

# (Opcional) Ejecutar seeders
php artisan db:seed

cd ..
```

### 3. Configurar Frontend (Nuxt + Quasar)

```bash
cd multiapp-nuxt-quasar

# Instalar dependencias de Node
npm install

# O si prefieres usar yarn
yarn install

cd ..
```

---

## ⚙️ Configuracion

### Backend (.env)

Edita el archivo `multiapp-backend-laravel/.env` con tus valores:

```env
APP_NAME="CV Torta"
APP_ENV=local
APP_DEBUG=true
APP_KEY=base64:xxx... (generado automáticamente)
APP_URL=http://localhost:8000

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=cvtorta
DB_USERNAME=cvtorta_user
DB_PASSWORD=tu_contraseña

SANCTUM_STATEFUL_DOMAINS=localhost:3000,127.0.0.1:3000
SESSION_DOMAIN=localhost
```

### Frontend (nuxt.config.ts)

La configuración principal ya está establecida en `multiapp-nuxt-quasar/nuxt.config.ts`:

- SSR deshabilitado para rutas específicas (`/auth`, `/`, `/agregar`, `/calendario`, `/perfil`)
- Quasar con idioma español
- Módulos necesarios integrados (Pinia, Icon, Image, etc.)

---

## 📁 Estructura del Proyecto

```
cv-torta/
├── multiapp-backend-laravel/          # Backend Laravel
│   ├── app/
│   │   ├── Http/Controllers/          # Controladores de API
│   │   ├── Models/                    # Modelos Eloquent
│   │   │   ├── User.php
│   │   │   ├── CvProfile.php
│   │   │   ├── CvEducation.php
│   │   │   ├── CvExperience.php
│   │   │   └── CvSkill.php
│   │   └── Providers/
│   ├── config/                        # Archivos de configuración
│   ├── database/
│   │   ├── migrations/                # Migraciones de BD
│   │   └── seeders/                   # Seeders (datos iniciales)
│   ├── routes/
│   │   └── api.php                    # Rutas de API
│   ├── storage/                       # Almacenamiento (logs, caché)
│   ├── tests/                         # Tests unitarios
│   ├── .env.example
│   ├── artisan
│   └── composer.json
│
├── multiapp-nuxt-quasar/              # Frontend Nuxt + Quasar
│   ├── app/
│   │   ├── app.vue                    # Componente raíz
│   │   ├── pages/                     # Páginas dinámicas
│   │   │   ├── index.vue              # Página principal
│   │   │   ├── auth.vue               # Autenticación
│   │   │   ├── agregar.vue            # Agregar CV
│   │   │   ├── perfil.vue             # Perfil de usuario
│   │   │   ├── calendario.vue         # Calendario
│   │   │   └── programas.vue          # Programas
│   │   ├── layouts/                   # Layouts
│   │   │   ├── default.vue            # Layout por defecto
│   │   │   └── public.vue             # Layout público
│   │   ├── stores/                    # Stores de Pinia
│   │   └── middleware/                # Middlewares
│   ├── plugins/                       # Plugins Nuxt
│   │   ├── quasar.client.js
│   │   └── pinia.client.js
│   ├── public/                        # Archivos estáticos
│   ├── nuxt.config.ts
│   ├── tsconfig.json
│   └── package.json
│
├── cvtorta.sql                        # Dump de base de datos
├── info.txt                           # Información de versiones
└── README.md                          # Este archivo
```

---

## 🔗 API Endpoints

La API está disponible en `http://localhost:8000/api`

### Autenticación

| Método | Endpoint | Descripción | Auth |
|--------|----------|-------------|------|
| POST | `/register` | Registrar nuevo usuario | ❌ |
| POST | `/login` | Iniciar sesión | ❌ |
| GET | `/user` | Obtener datos del usuario | ✅ |
| POST | `/logout` | Cerrar sesión | ✅ |

### Currículum Vitae

| Método | Endpoint | Descripción | Auth |
|--------|----------|-------------|------|
| GET | `/cv` | Obtener CV del usuario | ✅ |
| POST | `/cv` | Guardar/actualizar CV | ✅ |
| GET | `/cv/generate-pdf` | Generar PDF del CV | ✅ |

---

## 🗄️ Base de Datos - Esquema

### Tablas Principales

**users** - Usuarios del sistema
- id, name, email, password, created_at, updated_at

**cv_profiles** - Perfiles de CV
- id, user_id, nombre, apellido, email, telefono, direccion, ciudad, codigo_postal
- linkedin, github, portfolio, titulo_profesional, resumen_profesional
- template, configuracion, created_at, updated_at

**cv_educations** - Educación en el CV
- id, cv_profile_id, titulo, institucion, ubicacion, fecha_inicio, fecha_fin
- estudiando_actualmente, descripcion, promedio, orden

**cv_experiences** - Experiencia laboral en el CV
- id, cv_profile_id, puesto, empresa, ubicacion, fecha_inicio, fecha_fin
- trabajo_actual, descripcion, logros, orden

**cv_skills** - Habilidades en el CV
- id, cv_profile_id, nombre, categoria, nivel, nivel_texto, orden

**comidas** - Registro de comidas (módulo adicional)
- id, user_id, fecha, tipo, descripcion, calorias

---

## 🔨 Desarrollo

### Iniciar el Backend

```bash
cd multiapp-backend-laravel

# Iniciar servidor Laravel (puerto 8000)
php artisan serve

# O especificar un puerto diferente
php artisan serve --port=8001
```

### Iniciar el Frontend

```bash
cd multiapp-nuxt-quasar

# Iniciar servidor de desarrollo (puerto 3000)
npm run dev

# O con yarn
yarn dev
```

### Scripts Disponibles

**Backend:**
```bash
php artisan migrate              # Ejecutar migraciones
php artisan migrate:rollback     # Revertir última migración
php artisan db:seed              # Ejecutar seeders
php artisan tinker               # Shell interactivo Laravel
./vendor/bin/phpunit             # Ejecutar tests
```

**Frontend:**
```bash
npm run dev                       # Iniciar servidor de desarrollo
npm run build                     # Compilar para producción
npm run generate                  # Generar sitio estático
npm run preview                   # Ver compilación en local
```

---

## 🔐 Autenticacion (Sanctum)

La aplicación utiliza **Laravel Sanctum** para autenticación basada en tokens:

1. **Registro**: El usuario proporciona email y contraseña
2. **Login**: Se devuelve un token de autenticación
3. **Requests**: El token se incluye en el header `Authorization: Bearer {token}`
4. **Logout**: Invalida el token actual

### Flujo de Autenticación

```
1. Usuario ingresa en /auth
2. Completa formulario de login/registro
3. Frontend envía credenciales al backend
4. Backend valida y devuelve token
5. Frontend almacena token en Pinia (persistido)
6. Token se incluye en requests subsecuentes
7. Middleware 'auth:sanctum' valida requests
```

---

## 📦 Despliegue

### Preparar para Producción

**Backend:**
```bash
cd multiapp-backend-laravel

# Instalar solo dependencias de producción
composer install --no-dev --optimize-autoloader

# Configurar .env con valores de producción
APP_ENV=production
APP_DEBUG=false

# Ejecutar migraciones en servidor de producción
php artisan migrate --force

# Caché de configuración
php artisan config:cache
php artisan route:cache
```

**Frontend:**
```bash
cd multiapp-nuxt-quasar

# Construir para producción
npm run build

# Los archivos compilados estarán en .output/public
```

---

## 🐛 Troubleshooting

### El backend no se conecta a la base de datos
- Verificar que MySQL está ejecutándose
- Validar credenciales en `.env`
- Asegurar que la base de datos existe

### CORS errors en el frontend
- Verificar que `SANCTUM_STATEFUL_DOMAINS` en `.env` incluye tu dominio
- Asegurar que el backend permite requests desde el frontend

### Quasar no carga estilos
- Ejecutar `npm install` nuevamente
- Limpiar carpeta `node_modules` y `npm cache clean --force`

---

## 📄 Licencia

Este proyecto está bajo licencia **MIT**. Ver archivo `LICENSE` para más detalles.

---

## 👨‍💻 Autor

Desarrollado como proyecto de portfolio para demostrar habilidades full-stack con Nuxt, Quasar, Laravel y MySQL.

---

---

---

# CV Torta - CV Management Application

![GitHub](https://img.shields.io/badge/license-MIT-blue.svg)
![GitHub top language](https://img.shields.io/badge/frontend-Vue%203%2FNuxt%204-green.svg)
![GitHub top language](https://img.shields.io/badge/backend-Laravel%2012-red.svg)
![Database](https://img.shields.io/badge/database-MySQL%208.4-blue.svg)

## 📋 Table of Contents

- [Project Description](#project-description)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [API Endpoints](#api-endpoints)
- [Database](#database)
- [Development](#development)
- [Authentication](#authentication)
- [License](#license)

---

## 🎯 Project Description

**CV Torta** is a complete web application for managing and editing curriculum vitae. It allows users to create, edit, and download their resumes in PDF format with multiple templates available. The application features a modern and intuitive interface built with Vue 3 and Quasar, backed by a robust RESTful API in Laravel 12.

### Main Features

✨ **Complete CV Management**
- Create and edit professional profiles
- Manage education, work experience, and skills sections
- Multiple design templates
- Download CV in PDF format

🔐 **Authentication System**
- Secure registration and login
- Token-based authentication (Laravel Sanctum)
- User session management

📱 **Responsive Interface**
- Mobile-first design with Quasar Framework
- Intuitive and modern interface
- Icon graphics with FontAwesome

📊 **Additional Features**
- Events calendar
- Meal tracking (integrated module)
- Program and utilities management
- Personalized user dashboard

---

## 🛠️ Technology Stack

### Frontend
- **Nuxt 4** - Vue 3 meta-framework
- **Vue 3** - Progressive JavaScript framework
- **Quasar Framework** - UI component framework
- **Pinia** - State management (with persistence)
- **Axios** - HTTP client
- **Vite** - Bundler and module bundler
- **TypeScript** - Static typing
- **FontAwesome** - Icon library
- **@vueuse/nuxt** - Reusable composables

### Backend
- **Laravel 12** - PHP web framework
- **Laravel Sanctum** - API token authentication
- **Eloquent ORM** - Database ORM
- **PHP 8.3** - Programming language
- **PHPUnit** - Testing framework

### Database
- **MySQL 8.4** - Database management system
- **Laravel Migrations** - Database version control

### Node & Tools
- **Node.js 22** - Runtime environment
- **Composer** - PHP dependency manager
- **ESLint** - JavaScript/TypeScript linter
- **Laravel Pint** - PHP formatter

---

## 📋 Prerequisites

Before getting started, make sure you have installed:

- **PHP 8.3** or higher
- **Node.js 22** or higher
- **Composer** (PHP dependency manager)
- **npm** or **yarn** (Node dependency manager)
- **MySQL 8.4** or higher
- **Git** (to clone the repository)

---

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/cv-torta.git
cd cv-torta
```

### 2. Configure Backend (Laravel)

```bash
cd multiapp-backend-laravel

# Install PHP dependencies
composer install

# Create configuration file
cp .env.example .env

# Generate application key
php artisan key:generate

# Create MySQL database (execute in your MySQL client)
# mysql> CREATE DATABASE cvtorta;
# mysql> CREATE USER 'cvtorta_user'@'localhost' IDENTIFIED BY 'your_password';
# mysql> GRANT ALL PRIVILEGES ON cvtorta.* TO 'cvtorta_user'@'localhost';
# mysql> FLUSH PRIVILEGES;

# Run migrations
php artisan migrate

# (Optional) Run seeders
php artisan db:seed

cd ..
```

### 3. Configure Frontend (Nuxt + Quasar)

```bash
cd multiapp-nuxt-quasar

# Install Node dependencies
npm install

# Or if you prefer using yarn
yarn install

cd ..
```

---

## ⚙️ Configuration

### Backend (.env)

Edit the `multiapp-backend-laravel/.env` file with your values:

```env
APP_NAME="CV Torta"
APP_ENV=local
APP_DEBUG=true
APP_KEY=base64:xxx... (auto-generated)
APP_URL=http://localhost:8000

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=cvtorta
DB_USERNAME=cvtorta_user
DB_PASSWORD=your_password

SANCTUM_STATEFUL_DOMAINS=localhost:3000,127.0.0.1:3000
SESSION_DOMAIN=localhost
```

### Frontend (nuxt.config.ts)

The main configuration is already set in `multiapp-nuxt-quasar/nuxt.config.ts`:

- SSR disabled for specific routes (`/auth`, `/`, `/agregar`, `/calendario`, `/perfil`)
- Quasar with Spanish language
- Required modules integrated (Pinia, Icon, Image, etc.)

---

## 📁 Project Structure

```
cv-torta/
├── multiapp-backend-laravel/          # Laravel Backend
│   ├── app/
│   │   ├── Http/Controllers/          # API Controllers
│   │   ├── Models/                    # Eloquent Models
│   │   │   ├── User.php
│   │   │   ├── CvProfile.php
│   │   │   ├── CvEducation.php
│   │   │   ├── CvExperience.php
│   │   │   └── CvSkill.php
│   │   └── Providers/
│   ├── config/                        # Configuration files
│   ├── database/
│   │   ├── migrations/                # Database migrations
│   │   └── seeders/                   # Database seeders
│   ├── routes/
│   │   └── api.php                    # API routes
│   ├── storage/                       # Storage (logs, cache)
│   ├── tests/                         # Unit tests
│   ├── .env.example
│   ├── artisan
│   └── composer.json
│
├── multiapp-nuxt-quasar/              # Frontend Nuxt + Quasar
│   ├── app/
│   │   ├── app.vue                    # Root component
│   │   ├── pages/                     # Dynamic pages
│   │   │   ├── index.vue              # Home page
│   │   │   ├── auth.vue               # Authentication
│   │   │   ├── agregar.vue            # Add CV
│   │   │   ├── perfil.vue             # User profile
│   │   │   ├── calendario.vue         # Calendar
│   │   │   └── programas.vue          # Programs
│   │   ├── layouts/                   # Layouts
│   │   │   ├── default.vue            # Default layout
│   │   │   └── public.vue             # Public layout
│   │   ├── stores/                    # Pinia stores
│   │   └── middleware/                # Middleware
│   ├── plugins/                       # Nuxt plugins
│   │   ├── quasar.client.js
│   │   └── pinia.client.js
│   ├── public/                        # Static files
│   ├── nuxt.config.ts
│   ├── tsconfig.json
│   └── package.json
│
├── cvtorta.sql                        # Database dump
├── info.txt                           # Version information
└── README.md                          # This file
```

---

## 🔗 API Endpoints

The API is available at `http://localhost:8000/api`

### Authentication

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| POST | `/register` | Register new user | ❌ |
| POST | `/login` | Login | ❌ |
| GET | `/user` | Get user data | ✅ |
| POST | `/logout` | Logout | ✅ |

### Curriculum Vitae

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| GET | `/cv` | Get user's CV | ✅ |
| POST | `/cv` | Save/update CV | ✅ |
| GET | `/cv/generate-pdf` | Generate PDF CV | ✅ |

---

## 🗄️ Database

### Main Tables

**users** - System users
- id, name, email, password, created_at, updated_at

**cv_profiles** - CV profiles
- id, user_id, nombre, apellido, email, telefono, direccion, ciudad, codigo_postal
- linkedin, github, portfolio, titulo_profesional, resumen_profesional
- template, configuracion, created_at, updated_at

**cv_educations** - Education in CV
- id, cv_profile_id, titulo, institucion, ubicacion, fecha_inicio, fecha_fin
- estudiando_actualmente, descripcion, promedio, orden

**cv_experiences** - Work experience in CV
- id, cv_profile_id, puesto, empresa, ubicacion, fecha_inicio, fecha_fin
- trabajo_actual, descripcion, logros, orden

**cv_skills** - Skills in CV
- id, cv_profile_id, nombre, categoria, nivel, nivel_texto, orden

**comidas** - Meal tracking (additional module)
- id, user_id, fecha, tipo, descripcion, calorias

---

## 🔨 Development

### Start Backend

```bash
cd multiapp-backend-laravel

# Start Laravel server (port 8000)
php artisan serve

# Or specify a different port
php artisan serve --port=8001
```

### Start Frontend

```bash
cd multiapp-nuxt-quasar

# Start development server (port 3000)
npm run dev

# Or with yarn
yarn dev
```

### Available Scripts

**Backend:**
```bash
php artisan migrate              # Run migrations
php artisan migrate:rollback     # Rollback last migration
php artisan db:seed              # Run seeders
php artisan tinker               # Laravel interactive shell
./vendor/bin/phpunit             # Run tests
```

**Frontend:**
```bash
npm run dev                       # Start development server
npm run build                     # Build for production
npm run generate                  # Generate static site
npm run preview                   # Preview production build locally
```

---

## 🔐 Authentication

The application uses **Laravel Sanctum** for token-based authentication:

1. **Registration**: User provides email and password
2. **Login**: Returns an authentication token
3. **Requests**: Token is included in the `Authorization: Bearer {token}` header
4. **Logout**: Invalidates the current token

### Authentication Flow

```
1. User enters /auth
2. Completes login/registration form
3. Frontend sends credentials to backend
4. Backend validates and returns token
5. Frontend stores token in Pinia (persisted)
6. Token is included in subsequent requests
7. 'auth:sanctum' middleware validates requests
```

---

## 📦 Deployment

### Prepare for Production

**Backend:**
```bash
cd multiapp-backend-laravel

# Install only production dependencies
composer install --no-dev --optimize-autoloader

# Configure .env with production values
APP_ENV=production
APP_DEBUG=false

# Run migrations on production server
php artisan migrate --force

# Cache configuration
php artisan config:cache
php artisan route:cache
```

**Frontend:**
```bash
cd multiapp-nuxt-quasar

# Build for production
npm run build

# Compiled files will be in .output/public
```

---

## 🐛 Troubleshooting

### Backend cannot connect to database
- Verify MySQL is running
- Validate credentials in `.env`
- Ensure database exists

### CORS errors on frontend
- Verify `SANCTUM_STATEFUL_DOMAINS` in `.env` includes your domain
- Ensure backend allows requests from frontend

### Quasar not loading styles
- Run `npm install` again
- Clean `node_modules` folder and `npm cache clean --force`

---

## 📄 License

This project is licensed under the **MIT** License. See `LICENSE` file for details.

---

## 👨‍💻 Author

Developed as a portfolio project to demonstrate full-stack skills with Nuxt, Quasar, Laravel, and MySQL.

---
