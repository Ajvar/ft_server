service mysql start
mysql -e "CREATE DATABASE IF NOT EXISTS db; CREATE USER IF NOT EXISTS us@localhost IDENTIFIED BY 'pass'; GRANT ALL PRIVILEGES ON db.* TO us@localhost; FLUSH PRIVILEGES;"
service php7.3-fpm start
service nginx start
tail -f /dev/null