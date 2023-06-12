# README

This README would normally document whatever steps are necessary to get the
application up and running.

# Introduction:
    - The project is a web application that aims to provide users with a platform to share and watch funny movies. It allows users to create an account, login/register, share movie URLs, and view shared movies. The key features of the application include:
        1. User Authentication: Users can create an account, login, and register using their email and password. User authentication ensures secure access to the application and personalization of content.
        2. Movie Sharing: Authenticated users can share movie URLs by submitting the URL through a form. The shared movies are stored and displayed in the application for other users to view.
        3. Notification: After a user shares a movie by submitting the URL, a notification will be displayed to indicate the successful sharing process for other logged-in users.
        4. User Interaction: Users can interact with the shared movies by clicking on them to watch.
        5. Responsive Design: The application is designed to be responsive, adapting to different screen sizes and devices. It provides an optimal user experience on both desktop and mobile devices.
# Prerequisites: To successfully run the project, you will need the following software and tools installed on your system:
    1. Ruby: Ruby programming language. Ruby version 2.7.8
    2. Rails: Ruby on Rails framework. Rails 7.0.5
    3. SQLite: A lightweight, file-based database. Latest stable version
    4. RubyGems: Ruby's package manager Gem version 3.1.6
    5. Redis: An in-memory data structure store. Redis version 7.0.11
    6. Docker: A platform for containerization. Latest stable version
    7. Docker Compose: A tool for defining and managing multi-container Docker applications. Latest stable version (usually bundled with Docker)
# Installation & Configuration: To install and configure a Ruby on Rails project, follow these step-by-step instructions:
    * There are two common ways to start a BE Shared Videos project: using the built-in Rails server or using Docker.
        1. Starting the Project with the Built-in Rails Server follow the steps below:
            - Clone the repository: git clone <repository_url>
            - Ensure Ruby is installed on your system. You can check by running ruby --version. You can install it using a version manager like RVM (Ruby Version Manager) or rbenv
            - Install Ruby on Rails: gem install rails <version>
            - Install Redis and start Redis: Website: https://redis.io/docs/getting-started/. Note: need update config.redis_url = 'redis://localhost:6379/1' in config/application.rb 
            - Install SQLite: Website: https://www.sqlite.org
            - Install project dependencies:
                - Navigate to the project directory: cd <project_directory>
                - Run the following command to install project dependencies specified in the Gemfile: bundle install
                - Configure the database: rails db:create, rails db:migrate
            - Start the Rails server: rails server -p 3000.
            - The server will start running on http://localhost:3000, and you can access the application in your web browser.
        2. Starting the Project with Docker:
            - Ensure that Docker is installed on your system. You can check by running docker --version.
            - Note: need update config.redis_url = 'redis://redis:6379/1' in config/application.rb 
            - Build the Docker image by running the following command: 'docker build -t myapp .' or 'docker-compose build'
            - Start the Docker containers by running the following command: docker-compose up
            - The containers will start running, and you can access the application in your web browser at http://localhost:3000
# Database Setup: following step: Starting the Project with the Built-in Rails Server
# Running the Application: following two common ways:
    1. Starting the Project with the Built-in Rails Server
    2. Starting the Project with Docker
    3. Run the test suite: following command: rails test
# (BE/FS) Docker Deployment:    
# Usage: Here's a brief guide on how to use the application and some key features to be aware of:
    1. Registration and Login:
        * To access the application, users need to enter email and password information. Click on the "Login / Register" button and provide the required information.
        * After Login / Register, user can share videos.
    2. Home Page:
        * The home page may display Viewing a list of shared videos
    3. Sharing Videos:
        * Users can share videos by clicking on the "Share a movie" button.
        * Provide the URL or embed code of the video and any additional details required.
        * Upon successful sharing, a notification or confirmation message will be displayed.
    4. Notification:
        * When a user shares a new video successful, other logged-in users should receive a real-time notification about the newly shared video.  
    5. Viewing Videos:
        * Clicking on a video thumbnail or title will take the user to the video player page.
    6. Logging Out:
        * To log out of the application, users can click on the "Logout" button.
# Troubleshooting:
    1. Dependency Issues:
        * Problem: Missing or incompatible dependencies can cause installation or runtime errors.
        * Solution: Ensure that you have installed all the required dependencies and their appropriate versions. Review the project documentation or README file for the specific dependencies and versions needed.
    2. Can contact me: skype: bach.truong1 or Phone: 0379918661.