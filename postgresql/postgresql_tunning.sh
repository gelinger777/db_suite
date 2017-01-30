#!/bin/bash

# Скрипт установки и настройки сервера PostgreSQL
# Автор:  Олег Букатчук
# Версия: 0.8
# e-mail: oleg@bukatchuk.com

# Подключаем файл c настройками DB Suite
. ../db_suite.conf

# Подключаем FTP и монтируем его в директорию $FTP
curlftpfs -v -o iocharset=UTF-8 ftp://user:password@ftp.domain.ru/ /mnt/ftp

# Информируем пользователя
echo "Проверка текущей конфигурации..."

# Проверяем наличие эталонных файлов, если файлов нет
# выводим сообщение в консоль и останавливаем выполнение скрипта.
if [ ! -f $FTP_POSTGRESQL ];
    then
        # Информируем пользователя
        echo "В системе нет эталонных конфигурационных файлов!"\n
        echo "$FTP_POSTGRESQL"
        # Остановка скрипта
        exit 1
    else
        # Информируем пользователя
        echo "OK"
fi

# Проверяем наличие конфигурационных файлов, если файлов нет
# выводим сообщение в консоль и останавливаем выполнение скрипта.
if [ ! -d $CONFIG_POSTGRESQL ];
    then
        # Информируем пользователя
        echo "Идёт установка PostgreSQL..."
        # Установка PostgreSQL
        sudo apt-get update && sudo apt-get --allow --yes install postgresql-9.6
    else
        # Копирование конфигурации
        sudo cp $FTP_POSTGRESQL $CONFIG_POSTGRESQL
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

# Информируем пользователя
echo "Отправка отчёта на e-mail..."

# Отправляем письмо и push-уведомление в Telegram с указанием имени сервера
# на котором выполнился скрипт, датой, размером директории бекапов.
. $NOTICE/email.sh "Настройка $SERVER_NAME: сервера PostgreSQL установлен!" "$SPACE_USED"
. $NOTICE/telegram.sh "Настройка $SERVER_NAME: сервера PostgreSQL установлен!" "$SPACE_USED"

# Информируем пользователя
echo "OK"

# Возвращаем общий результат, иначе возвращается результат выполнения последней команды.
exit 0
