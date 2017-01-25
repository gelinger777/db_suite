#!/bin/bash

# Скрипт настройки сервера PostgreSQL 9.x
# Автор:  Олег Букатчук
# Версия: 0.1
# e-mail: oleg@bukatchuk.com

# Создаём константу для подключеня к базе данных.
export CONNECT_DB=postgresql://password:login@127.0.0.1:5432/database

# Создаём константу из абсолютного пути к скрипту.
export RUN_ME=/path/to/script/postgresql_tunning.sh

# Создаём константу для директории хранения конфигов.
export CONFIG=/path/to/backup/dir

# Подключаем FTP и монтируем его в директорию $FTP
curlftpfs -v -o iocharset=UTF-8 ftp://user:password@ftp.domain.ru/ /mnt/ftp

# Создаём константу для директории монтирования FTP.
export FTP=/mnt/ftp

# Информируем пользователя
echo "Проверка эталонной конфигурации..."

# Проверяем наличие конфигурационных файлов, если файлов нет 
# выводим сообщение в консоль и останавливаем выполнение скрипта.
if [ ! -f $FILES ]; 
    then
        # Информируем пользователя
        echo "В системе нет эталонных конфигурационных файлов!"\n
        echo "$FILES"
        # Остановка скрипта
        exit 1
    else
        # Информируем пользователя
        echo "OK"
fi

# Информируем пользователя
echo "Применение эталонной конфигурации сервера..."

# Перезагужаем сервер для применения новой конфигурации
sudo service postgresql restart

# Информируем пользователя
echo "OK"

# Выводим статус сервера
sudo service postgresql status

echo "Настройка сервера PostgreSQL выполнена успешно!"
