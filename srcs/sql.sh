service mysql start
mysql -e "CREATE DATABASE IF NOT EXISTS db; CREATE USER IF NOT EXISTS us@localhost; GRANT ALL PRIVILEGES ON db.* TO us@localhost; FLUSH PRIVILEGES;"
service nginx start
service php7.3-fpm start
tail -f /dev/null