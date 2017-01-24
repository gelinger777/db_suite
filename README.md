## Прочитайте внимательно! 
Это набор скриптов для создания дампов баз данных MySQL 5.x/6.x и PostgreSQL 9.x. 

### Возможности скриптов
- Создание дампов баз данных (по расписанию). 
- Ротация бекапов (поиск и удаление старых дампов).

## Установка
Клонируем репозиторий:
```markdown
git clone https://github.com/olegbukatchuk/backup_scripts
```
Делаем скрипт исполняемым:
```markdown
sudo chmod +x /path/to/script/backup_mysql.sh
```
Выставляем права доступа на директорию хранения бекапов:
```markdown
sudo chmod -R 770 /path/to/backup/mysql
```
и прописываем значения переменных и констант для корректного выполнения процедуры снятия дампов. 

### MySQL 5.x/6.x
Определяем переменные и константы для соединения с базой данных MySQL в файле mysql.sh

```markdown
# Объявляем переменные для авторизации в MySQL.
export HOST_MYSQL=host
export USER_MYSQL=login
export PASS_MYSQL=password
export DB_MYSQL=database

# Создаём константу из абсолютного пути к скрипту.
export RUN_ME=/path/to/script/backup_mysql.sh

# Создаём константу для директории хранения бекапов.
export STORAGE=/path/to/backup/mysql
```

### PostgreSQL 9.x
Определяем переменные и константы для соединения с базой данных PostgreSQL в файле postgresql.sh

```markdown
# Создаём константу для подключеня к базе данных.
export CONNECT_DB=postgresql://password:login@host:5432/database

# Создаём константу из абсолютного пути к скрипту.
export RUN_ME=/path/to/script/backup_postgresql.sh

# Создаём константу для директории хранения бекапов.
export STORAGE=/path/to/backup/dir
```
### Пример работы скрипта
```markdown
user@host:~$ /path/to/script/backup_mysql.sh 
Проверка наличия директории для хранения бекапов...
OK
Идёт создание дампа БД...
OK
Идёт поиск и удаление старых дампов БД...
ОК
Проверка наличия задания в Cron'e...
0 1 * * * /path/to/scripts/backup_mysql.sh
OK
```
Все скрипты умеют работать, как с локальным, так и с сетевым сокетом, поэтому задание можно запускать не только на сервере, где находиться база данных, но и на удалённом хосте.

Не забудьте при необходимости повторения процедуры поставить задание в планировщик у себя на сервере.

### 
Ставим скрипт на выполнение (из консоли) в 1 час 00 минут после полуночи ежедневно:

```markdown
crontab -e

# Добавляем в конец файла наше задание

0 1 * * * /path/to/scripts/backup_mysql.sh
```
Сохраняем и перезапускаем Cron:

```markdown
sudo service cron restart
```
Готово!

### Поддержка и контакты

Есть вопрос или предложение? Свяжитесь со мной любым удобным вам способом из представленных у меня на сайте [bukatchuk.com](https://bukatchuk.com/contacts/).

# P.S.
### Синтаксис Cron'a
```markdown
# * * * * * "/команда/которая/будет/выполнена"
# - - - - -
# | | | | |
# | | | | ----- День недели (0 - 7) (Воскресенье=0 или 7, 0-Вс,1-Пн,2-Вт,3-Ср,4-Чт,5-Пт,6-Сб,7-Вс)
# | | | ------- Месяц (1 - 12)
# | | --------- Число (1 - 31)
# | ----------- Часы (0 - 23)
# ------------- Минуты (0 - 59)
```
