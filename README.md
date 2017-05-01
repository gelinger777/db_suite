
# STILL  THIS SOFTWARE IS IN RUSSIAN. WE WILL REMOVE THIS NOTICE AS SOON AS IT"S TRANSLATED FULLY INTO ENGLISH!!!



# DB Suite v1.9 [![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)
Bash Scripts for backing up  MySQL/PostgreSQL

## features
- Setup and configuration of new MySQL/PostgreSQL: deploying a new server
- Creating scheduled  dump files of databases 
- Rotation of backups:search and delition of the backups.
- Sync of the local dumps with remote ftp-server.
- Sending e-mail notifications via  SMTP-server.
- Sending Telegram notifications.
- Debug mode: logging any commands done by the script.
- General Config file: setting variables as constants.

## Setup
Clone Repo:
```markdown
git clone https://github.com/gelinger777/db_suite
```
then setup configuration variables at config.sh. Also in  action/email.sh setup server for sending email notifications and reports to your  e-mail.

### Example of work
```markdown
user@host:~$ /path/to/db_suite/postgresql/postgresql_backup.sh 
Проверка наличия директории для хранения бекапов...
OK
Идёт создание дампа БД...
Загружено:  623MiB 0:00:20 [30.5MiB/s] [                        <=>                                ]
OK
Идёт поиск и удаление старых дампов БД...
ОК
Проверка наличия задания в Cron'e...
0 1 * * * /path/to/db_suite/postgresql/postgresql_backup.sh
OK
```
Все скрипты умеют работать, как с локальным, так и с сетевым сокетом, поэтому задание можно запускать не только на сервере, где находиться база данных, но и на удалённом хосте.

Не забудьте при необходимости повторения процедуры поставить задание в планировщик у себя на сервере.

Setting up a cronjob   to be run at  1:00 AM  daily:

```markdown
crontab -e

# add the following line with right path

0 1 * * * /path/to/db_suite/postgresql/postgresql_backup.sh
```
Save and restart the  Cron:

```markdown
sudo service cron restart
```
Ready!

## Credits 

 Oleg Bukatchuk aka  @olegbukatchuk  [bukatchuk.com](https://bukatchuk.com/contacts/).
