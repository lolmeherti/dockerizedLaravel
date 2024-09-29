# Dockerized Laravel Setup

This repository provides a Dockerized setup for a Laravel application, aimed at facilitating an out-of-the-box development and deployment environment using Docker and Docker Compose. It encapsulates the necessary components to develop, test, and deploy Laravel applications with ease.

## Prerequisites

Before proceeding, make sure you have installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Git](https://git-scm.com/doc)

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

   ***If you're creating an application from scratch, ignore the following and skip over to the third step***
   <br/>  
   If your application doesn't already have a repository on [Github](https://github.com/), create one and execute the following:<br/>  
   Navigate to your application directory in the command line. Replace `PATH` with the path of your pre-existing application.
   ```bash
   cd PATH
   ```

   Initiate a git repository
   ```bash
   git init
   ```
   
   Connect your local environmet to the github repository. Replace `PATH` with the URL of your newly created github repository, e.g: `https://github.com/username/projectName`.
   
   ```bash
   git remote add origin PATH
   ```

   Add all project files/directories to the staging area (ensure that the files that you dont want to be publicly exposed, are placed within a `.gitignore` file so they arent pushed)
   ```bash
   git add .
   ```

   Check that the files have been staged - with staged files appearing green in the response.
   ```bash
   git status
   ```

   Commit staged files
   ```bash
   git commit -m "[Initialises] repository"
   ```

   Push commit to github repository (***if you're using a different branch name to `master`, specify that branch instead of using `master`***)
   ```bash
   git push -u origin master
   ```
   <br/>
   <ins>Replace built in laravel application with pre-built application</ins><br/>
   <br/>  
   Navigate to the directory of the dockerizedLaravel template (you'll have named it after your project at the beginning of step 2)

   ---
   **Windows**
   <br/>  
   Remove pre-built application
   ```bash
   rmdir /s /q laravel
   ```

   Clone pre-built application repository and name it `laravel`. Replace `PATH` with the URL of your github repository, e.g: `https://github.com/username/projectName`.
   ```bash
   git clone PATH laravel
   ```
   ---
   **WSL/Linux Systems**
   <br/>
   <br/>
   Remove pre-built application
   ```bash
   sudo rm -Rf laravel
   ```
   Clone pre-built application repository and name it `laravel`. Replace `PATH` with the URL of your github repository, e.g: `https://github.com/username/projectName`.
   ```bash
   sudo git clone PATH laravel
   ```
   Since you've now replaced the application which comes with the template, with your own pre-built one - you'll need to set the ownership/permissions again for the application to function properly.
   ```bash
   sudo chown -R www-data:www-data /var/www/html/ProjectName && chmod -R 777 /var/www/html/ProjectName
   ```
   <br/>
3. **Set Up Environment File**

    Create a `.env` file within the the `/src/laravel` directory of your project. Replace `ProjectName` with the actual name of your project.
  
    Copy the contents of the `.env.example` file from the official Laravel github repository, then paste into the `.env` that you've just created. Then fill in the database 
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

   **Docker Desktop**
   <br/>  
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
   ---
   **CMD**
   <br/>  
   If you want to install the composer packages via the CMD, do the following:
   <br/>  
   ***if your application container aren't running, execute `docker-compose up -d` or `docker-compose up -d --force-recreate`***
   <br/>  
   Display a list of the running containers
   ```bash
   docker ps
   ```
   Copy the container ID that's related to the php-cli-local image. Replace `ContainerID` with your container ID
   ```bash
   docker exec -it ContainerID bash
   ```
   Check the working directory and the contents within that working directory. You should be in `/var/www/html`, and within the contents should be: `laravel`
   ```bash
   pwd && ls
   ```   
   Make sure that comspoer is installed
   ```bash
   composer -v
   ```
   ***If it isn't installed, ensure that the image has been built correctly; has the correct pathing.***<br/>  
   If there's no issues, install the packages
   ```bash
   composer install
   ```
   <br/>
7. **Generate Application Key**  
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
   Generate application key
   ```bash
   php artisan key:generate
   ```
   <br/>
8. **Run Migrations**

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
