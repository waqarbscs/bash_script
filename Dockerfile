FROM ubuntu

#install all the tools you might want to use in your container
RUN apt-get update
RUN apt-get install nano
#the following ARG turns off the questions normally asked for location and timezone for Apache
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install apache2 -y
RUN apt install software-properties-common -y 
RUN add-apt-repository ppa:ondrej/php
RUN apt-get install  php8.0-mbstring php8.0-gettext php8.0 php8.0-common php8.0-opcache php8.0-mcrypt php8.0-cli php8.0-gd php8.0-curl php8.0-mysql -y
RUN apt install mysql-server -y
RUN a2enmod rewrite
RUN a2dismod autoindex -f
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN cp /usr/local/bin/composer /usr/bin
RUN apt-get install git -y

#change working directory to root of apache webhost
WORKDIR var/www/html
RUN chown -R www-data:www-data *
#now start the server
#CMD ["apachectl", "-D", "FOREGROUND"]
