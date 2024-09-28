# Dockerized Laravel Setup

This repository provides a Dockerized setup for a Laravel application, aimed at facilitating an out-of-the-box development and deployment environment using Docker and Docker Compose. It encapsulates the necessary components to develop, test, and deploy Laravel applications with ease.

## Prerequisites

Before proceeding, make sure you have installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

Follow these steps to get your Laravel application running:

1. **Navigate to the location where you'd like to place the template**<br/>  
   Windows
   ```bash
   cd PathToDir
   ```

   WSL/Linux Systems
   ```bash
   cd /var/www/html 
   ```
   <br/>

2. **Clone the Repository**

    Replace `ProjectName` with the name of your application <br/>  
    Windows
    ```bash
    git clone https://github.com/lolmeherti/dockerizedLaravel ProjectName && cd ProjectName
    ```

   WSL/Linux Systems (Also setting file ownership and permissions)
    ```bash
    sudo git clone https://github.com/lolmeherti/dockerizedLaravel ProjectName && cd ProjectName && sudo chown -R www-data:www-data /var/www/html/ProjectName && chmod -R 777 /var/www/html/ProjectName
    ```
   <br/>
3. **Set Up Environment File**

    Copy the `.env.example` file from the official Laravel github repository to `.env`. Then fill in the database 
    credentials of the `.env` with those that you find in the `docker-compose.yml`:
    <br/>  
    Laravel github repository:
   
   ```bash
   https://github.com/laravel/laravel
    ```
   <br/>

4. **Build `phpcli` and `phpfpm` Images**
   
   Assuming that you are still in the root repository for the template, navigate to the respective directories for `phpcli` 
   and `phpfpm`. Clone each one, then return to the root directory for the project.<br/>  
   Windows
   ```bash
   cd phpcli && docker build -t php-cli-local:latest . && cd ../phpfpm && docker build -t php-fpm-local:latest . && cd ..
   ```
   WSL/Linux Systems
   ```bash
   cd phpcli && sudo docker build -t php-cli-local:latest . && cd ../phpfpm && sudo docker build -t php-fpm-local:latest . && cd ..
   ```
   <br/>
   
   To ensure that the images have been built successfully, run the command below in the command line. You should see two new images built, called
   `php-cli-local` and `php-fpm-local`.
   ```bash
   docker images
   ```
   <br/>

5. **Build and Run with Docker Compose**

    Build the Docker images and start the services:

    ```bash
    docker-compose up -d
    ```
   <br/>  
   
   ***If you have attempted to build the containers previously, execute the following to rebuild them***
   ```bash
   docker-compose up -d --force-recreate
   ```
   <br/>
6. **Install Composer Packages**  
   Navigate to the `docker desktop` - then select the running ``php-cli`` container. Click on the `exec` tab. 
   Complete the following in the command line:<br/>  
   Open bash
   ```bash
   bash
   ```
   Navigate to the application
   ```bash
   cd laravel
   ```
   ***If the path doesn't exist, ensure that the pathing for the mount of the `php-cli` container is correct***
   <br/>  
   Ensure composer is installed
   ```bash
   composer -v
   ```
   ***If it isn't installed, ensure that the image has been built correctly; has the correct pathing.***<br/>  
   If there's no issues, install the packages
   ```bash
   composer install
   ```
   <br/>
7. **Generate API key**  
   Navigate to the `php-fpm` container on the `docker desktop`. Then select the `exec` tab, and write the following in the command line:<br/>  
   Open bash
   ```bash
   bash
   ```
   Navigate to the application
   ```bash
   cd laravel
   ```
   ***If the path doesn't exist, ensure that the pathing for the mount of the `php-fpm` container is correct***
   <br/>   
   Generate API key
   ```bash
   php artisan key:generate
   ```
   <br/>
8. **Run Migrations (Optional)**

    If you have database migrations to run - following where you left off after generating an API key, execute:

    ```bash
    php artisan migrate:fresh
    ```
   <br/>

9. **Accessing the Application**

    Visit `http://localhost` in your web browser to access your Laravel application - or select on the highlighted port on `docker desktop`, under the `Port(s)` column; for the `nginx` container.

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
