FROM debian:buster

LABEL maintainer="jcueille@student.42.fr"

WORKDIR /tmp

#############################
# Installing required tools #
#############################

RUN apt update && \
    apt-get upgrade -y && \
    apt-get install -y wget && \ 
    apt-get install -y gnupg2 wget apt-utils && \
    apt-get install -y nginx && \
    apt-get install -y mariadb-server && \
    apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline

#######
# ssl #
#######

COPY /srcs/server.key /tmp
COPY /srcs/server.crt /tmp

#####################
# Phpmyadmin install#
#####################

RUN wget -O phpmyadmin.tar.gz https://files.phpmyadmin.net/phpMyAdmin/5.0.0/phpMyAdmin-5.0.0-english.tar.gz && \
    mkdir /var/www/html/phpmyadmin && \
    tar -xvf phpmyadmin.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin && \
    rm phpmyadmin.tar.gz

###########################
# Wordpress / Nginx setup #
###########################
COPY srcs/wp-config.php /var/www/html/
RUN rm -f /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
RUN wget -O latest.tar.gz https://wordpress.org/latest.tar.gz
RUN mkdir /var/www/html/wordpress
RUN tar -xvf latest.tar.gz --strip-components=1 -C /var/www/html/wordpress
RUN rm latest.tar.gz
COPY srcs/config /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/config /etc/nginx/sites-enabled/

# Creating DB
COPY srcs/sql.sh .
ENTRYPOINT ["/bin/sh", "/tmp/sql.sh"]


