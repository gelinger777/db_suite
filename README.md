## Скрипты для резервного копирования баз данных

Набор боевых скриптов для создания дампов баз данных в СУБД: MySQL 5.x/6.x, PostgreSQL 9.x всё, что вам нужно сделать это скопировать скрипт на сервер и определить значения переменных и констант для корректного выполнения процедуры снятия 
дампов и поставить задание в планировщик у себя на сервере. 

Все скрипты умеют работать, как с локальным. так и с сетевым сокетом, поэтому задание можно запускать не только на сервере, где находиться база данных, но и на удалённом хосте.

### 
```markdown
user@host:~$ /path/to/script/backup_postgresql.sh 
Проверка наличия директории для хранения бекапов...
OK
Идёт создание дампа БД...
OK
Идёт поиск и удаление старых дампов БД...
ОК
Проверка наличия задания в Cron'e...
0 1 * * * /path/to/backup_mysql.sh
OK
```

### MySQL

Определение констант и переменных для соединения с базой данных Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### PostgreSQL

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
