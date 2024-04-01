# Dockerized Laravel Setup

This repository provides a Dockerized setup for a Laravel application, aimed at facilitating an out-of-the-box development and deployment environment using Docker and Docker Compose. It encapsulates the necessary components to develop, test, and deploy Laravel applications with ease.

## Prerequisites

Before proceeding, make sure you have installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

Follow these steps to get your Laravel application running:

1. **Clone the Repository**

    ```bash
    git clone https://github.com/lolmeherti/dockerizedLaravel.git && cd dockerizedLaravel
    ```

2. **Set Up Environment File**

    Copy the `.env.example` file to `.env` and fill in the database credentials you find in the docker-compose.yml:

    ```bash
    cp .env.example .env
    ```

3. **Build and Run with Docker Compose**

    Build the Docker images and start the services:

    ```bash
    docker-compose up --build -d
    ```

4. **Generate an Application Key**

    Generate a new application key for Laravel:

    ```bash
    docker-compose exec app php artisan key:generate
    ```

5. **Run Migrations (Optional)**

    If you have database migrations to run, execute:

    ```bash
    docker-compose exec app php artisan migrate
    ```

6. **Accessing the Application**

    Visit `http://localhost` in your web browser to access your Laravel application.

## Services Included

This setup includes the following services:

- **PHP-FPM:** Handles PHP processing.
- **PHP-CLI:** Runs PHP scripts.
- **NODE:** Used to install dependencies of Laravel.
- **Nginx:** Serves your Laravel application.
- **MySQL:** Provides a database for your application.
- **PHPMYADMIN:** (Optional) Can be used to view your MySQL tables in a GUI.

## Configuration

Detailed instructions on configuring each component are provided below.

### Docker Compose

The `docker-compose.yml` file orchestrates the setup and configuration of the services required to run your Laravel application. It defines services like `app` for the Laravel application, `nginx` for the web server, and `mysql` for the database. Customize it as needed to match your development or production requirements.

### Laravel Environment

The `.env` file contains environment variables for your Laravel application. It's crucial to set these variables to ensure your application connects correctly to the services defined in `docker-compose.yml`.

### Laravel Dependency Management

- Use the **NODE** container to run `npm install` in the `/src/laravel` folder.
- Use the **PHP-CLI** container to run `composer install` in the `/src/laravel` folder.

## License

This Dockerized Laravel setup is open-sourced software licensed under the [MIT license](LICENSE).
