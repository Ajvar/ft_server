FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt-get upgrade
RUN apt-get install -y dialog apt-utils
RUN apt-get install -y wget 
RUN apt-get install -y nginx 
RUN apt-get install -y mariadb-server 
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline 
RUN apt-get install -y libnss3-tools
COPY srcs/wordpress /var/www/html
COPY srcs/default.conf /etc/nginx/sites-available
RUN cd /var/www/html
RUN wget -O phpmyadmin.tar.gz https://files.phpmyadmin.net/phpMyAdmin/5.0.0/phpMyAdmin-5.0.0-english.tar.gz
RUN tar -xvf phpmyadmin.tar.gz
RUN rm phpmyadmin.tar.gz
RUN mv phpMyAdmin-5.0.0-english phpmyadmin 

# Creating DB

RUN service mysql restart
RUN mysql -u root -p


