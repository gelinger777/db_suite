#!/bin/bash

# Скрипт экспорта БД из MySQL
# Автор:  Олег Букатчук
# Версия: 1.9
# e-mail: oleg@bukatchuk.com

# Подключаем конфиг
source "../config.sh"

# Информируем пользователя
echo "Идёт проверка зависимостей скрипта..."

# Проверяем наличие утилиты pv, если нет ставим её.
if [ "" == "${PV_OK}" ];
then
    # Ставим пакет pv (для отрисовки прогресс-бара).
    echo "Установка зависимостей скрипта..."
    sudo apt-get --force-yes --yes install pv
fi

if [ "" == "${SENDEMAIL_OK}" ];
then
    # Ставим пакет sendemail.
    sudo apt-get --force-yes --yes install sendemail
fi

# Информируем пользователя
echo "OK"

# Проверяем наличие директории для бекапов, если директории нет 
# выводим сообщение в консоль и останавливаем выполнение скрипта.
if [ ! -d ${STORAGE} ];
    then
        # Информируем пользователя
        echo "В системе нет требуемой директории!"\n
        echo "${STORAGE}"
        exit 1
    else
        # Информируем пользователя
        echo "Идёт создание дампа БД..."
fi

# Создаём дамп базы данных, рисуем прогресс бар, называем бекап текущей датой и архивируем его.
mysqldump --host=${HOST_MYSQL} \
          --user=${USER_MYSQL} \
          --password=${PASS_MYSQL} ${DB_MYSQL} \
          | pv -N "Загружено" \
          > ${STORAGE}/$(date +%Y-%m-%d).sql \
          | gzip > ${STORAGE}/$(date +%Y-%m-%d).sql.gz

# Информируем пользователя
echo "OK"

# Информируем пользователя
echo "Идёт поиск и удаление старых дампов БД..."

# Находим файлы старше 7 дней в директории $STORAGE и удаляем их.
find ${STORAGE} -type f -mtime +7 -exec rm -f {} \;

# Информируем пользователя
echo "ОК"

# Информируем пользователя
echo "Проверка наличия задания в Cron'e..."

# Преверяем наличие записи в планировщике, если нет выводим сообщение и подсказку.
if crontab -l | grep "${RUN_MYSQL_BACKUP}";
    then
        echo "OK"
    else
        echo "Добавьте задание в Cron."
fi

# Информируем пользователя
echo "Отправка отчёта на e-mail..."

# Отправляем письмо с указанием имени сервера на котором выполнился скрипт.
source "${EMAIL}/email.sh" "${SERVER_NAME}: backup на $(date +%Y-%m-%d) готов!" "${SPACE_USED}"

# Информируем пользователя
echo "OK"

# Возвращаем общий результат, иначе возвращается результат выполнения последней команды.
exit 0

# Ставим скрипт на выполнение (из консоли) в 1 час 00 минут после полуночи ежедневно:  
# 0 1 * * * /path/to/scripts/backup_mysql.sh

# Cron шпаргалка:
# * * * * * "/команда/которая/будет/выполнена"
# - - - - -
# | | | | |
# | | | | ----- День недели (0 - 7) (Воскресенье=0 или 7, 0-Вс,1-Пн,2-Вт,3-Ср,4-Чт,5-Пт,6-Сб,7-Вс)
# | | | ------- Месяц (1 - 12)
# | | --------- Число (1 - 31)
# | ----------- Часы (0 - 23)
# ------------- Минуты (0 - 59)
