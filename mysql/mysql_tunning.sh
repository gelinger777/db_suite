#!/bin/bash

# Скрипт установки и настройки сервера MySQL
# Автор:  Олег Букатчук
# Версия: 0.5 alpha
# e-mail: oleg@bukatchuk.com

# Подключаем файл c настройками DB Suite
. ../db_suite.conf

# Подключаем FTP и монтируем его в директорию $FTP
curlftpfs -v -o iocharset=UTF-8 ftp://user:password@ftp.domain.ru/ /mnt/ftp

# Информируем пользователя
echo "Проверка текущей конфигурации..."

# Проверяем наличие конфигурационных файлов, если файлов нет
# выводим сообщение в консоль и останавливаем выполнение скрипта.
if [ ! -d $CONFIG_MYSQL ];
    then
        # Информируем пользователя
        echo "В системе нет конфигурационных файлов сервера MySQL!"\n
        echo "$CONFIG_MYSQL"
        # Остановка скрипта
        exit 1
    else
        # Информируем пользователя
        echo "OK"
fi

# Проверяем наличие эталонных файлов, если файлов нет
# выводим сообщение в консоль и останавливаем выполнение скрипта.
if [ ! -d $FTP ];
    then
        # Информируем пользователя
        echo "В системе нет эталонных конфигурационных файлов!"\n
        echo "$FTP"
        # Остановка скрипта
        exit 1
    else
        # Информируем пользователя
        echo "OK"
fi

# Информируем пользователя
echo "Применение эталонной конфигурации сервера..."



# Перезагужаем сервер для применения новой конфигурации
sudo service mysql restart

# Информируем пользователя
echo "OK"

# Выводим статус сервера
sudo service mysql status

echo "Настройка сервера MySQL выполнена успешно!"

# Информируем пользователя
echo "Отправка отчёта на e-mail..."

# Отправляем письмо с указанием имени сервера на котором выполнился скрипт,
# датой, размером директории бекапов.
. $NOTICE/email.sh "Настройка $SERVER_NAME: сервер MySQL установлен!" "$SPACE_USED"

# Информируем пользователя
echo "OK"

# Возвращаем общий результат, иначе возвращается результат выполнения последней команды.
exit 0
