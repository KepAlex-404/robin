# 1. Почему нам понадобился тайпорм
В погоне за написанием длительно масштабируемых веб приложений мы решили, что к месту будет испльзовать возможности тайп скрипта и самый популярный для веб приложений написаных на тайпскрипте орм - тайпорм. 

Основные заслуги тайпорм:

-достаточно низкий уровень вхождения, что отлично подходит для нас, студентов;

-наличие развитой инфраструктуры;

-автоматизация большого количества процессов, которые ранее писались вручную;

Прелесть использования объектно реляционного отображения типичным использованием запросов к базе данных напрямую из кода состоит в том, что можно делать всё тоже, но используя объектно ориентированую парадигму и автоматизировать большинство процессов, таких как генерация и миграция таблиц баз данных.
# 2. Что такое тайпорм и почему мы выбрали его среди других орм

TypeORM это ОРМ, которая может запускаться в NodeJS, Browser, Cordova, и другие, и может использоваться с TypeScript и JavaScript. Его цель - всегда поддерживать новейшие функции JavaScript и предоставлять дополнительные функции, которые помогут вам разрабатывать любые приложения, использующие базы данных - от небольший приложений с несколькими таблицами до крупномасштабных корпоративных приложений с несколькими базами данных. 

Тайп орм используется на всех этапах разработке слоя данных ПО. С помощью заранее прописаных типизированых entities мы можем иметь в коде интерферс который будет дублировать модель отображения данных в бд и сразу предоставлять доступ к большому количеству операций над данными.

# 3.
1. где найти доку офф сайт и развитое сообщество https://join.slack.com/t/typeorm/shared_invite/enQtNDQ1MzA3MDA5MTExLTUxNTZhM2Q4NDNhMjMzNjQ2NGM1ZjI1ZGRkNjJjYzI4OTZjMGYyYTc0MzAxYTdjMWE3ZDIxOWUzZTdlM2QxNTY
2. вопрос установки и подключения драйвера базы данных
3. 1-й этап роботы: подключение к базе данных
4. 2-й этап роботы: написание энтити
5. 3-й написание для энтити репозитория и запросы к базе данных

## вопрос установки:
Установить npm пакет:
```bash
npm install typeorm --save
```

Возможно потребуется установить node typings:
```bash
npm install @types/node --save
```

Установить драйвер для PostreSQL:
```bash
npm install pg --save
```
Также поддерживаются, MySQL, MariaDB, PostgreSQL, CockroachDB, SQLite, Microsoft SQL Server, sql.js, Oracle, SAP Hana, MongoDB.

## 1-й этап работы: подключение к базе данных

```javascript
import { createConnection } from 'typeorm';

export const databaseProviders = [
  {
    provide: 'DATABASE_CONNECTION',
    useFactory: async () =>
      await createConnection({
        type: 'mysql',
        host: 'localhost',
        port: 3306,
        username: 'root',
        password: 'test',
        database: 'test',
        entities: [__dirname + '/../**/*.entity{.ts,.js}'],
        synchronize: true,
      }),
  },
];
```
В данном примере мы подключаемся к MySQL. Мы добавили наши список entities для этого подключения. Все entities, что вы используете, должны быть указаны здесь. Настройка синхронизации гарантирует, что ваши объекты будут синхронизироваться с базой данных при каждом запуске приложения.

## 2-й этап работы: написание энтити
Работа с базы данных начинается с создания таблица. Энтити в модели декорированы @Entity декоратором. Для таких моделей будет создана таблица базы данных. Вы работаете с объектами везде с TypeORM. Вы можете загружать,вставлять, обновлять, удалять и выполнять другие операции с ними.

Чтобы добавить столбцы базы данных, вам просто нужно декорировать свойства энтити, которые вы хотите сделать, в столбец с помощью декоратора @Column.

Каждый объект должен иметь хотя бы один столбец первичного ключа - это обязательное требование. Чтобы сделать столбец первичным ключом, вам нужно использовать декоратор @PrimaryColumn.

Теперь предположим, что вы хотите, чтобы ваш столбец идентификаторов генерировался автоматически. Для этого вам нужно изменить декоратор @PrimaryColumn на декоратор @PrimaryGeneratedColumn:

Итак, созданим энтити пользователя:
```javascript
import { Entity, Column, PrimaryGeneratedColumn, OneToMany } from 'typeorm';

@Entity()
export class User {
  @PrimaryGeneratedColumn('uuid')
  user_id?: string;

  @Column()
  email: string;

  @Column()
  username: string;

  @Column()
  password: string;
}
```

Сейчас будет создана бд таблица для энтити юзера и мы сможем работать с ней откуда угодно с нашего приложения.

## 3-й этап работы: написание для энтити репозитория

Используя репозиторий, можно управлять (вставлять, обновлять, удалять, закружать, и т.д.) конкретной энтити.

```javascript
import { Injectable, Inject, Logger } from '@nestjs/common';
import { Repository } from 'typeorm';
import { User } from './user.entity';

@Injectable()
export class UsersService {
  constructor(
    @Inject('USER_REPOSITORY')
    private userRepository: Repository<User>,
  ) {}

  async findByEmail(email: string): Promise<User> {
    Logger.debug('UsersService:findByEmail');
    return await this.userRepository.findOne({
      where: {
        email: email,
      },
    });
  }

  async findByUsername(username: string): Promise<User> {
    Logger.debug('UsersService:findByUsername');
    return await this.userRepository.findOne({
      where: {
        username: username,
      },
    });
  }

  async findById(user_id: number): Promise<User> {
    Logger.debug('UsersService:findById');
    return await this.userRepository.findOne({
      where: {
        user_id: user_id,
      },
    });
  }

  async create(user: User): Promise<User> {
    Logger.debug('UsersService:create');
    return await this.userRepository.save(user);
  }

  async remove(user_id: number): Promise<void> {
    Logger.debug('UsersService:remove');
    await this.userRepository.delete(user_id);
  }
}
```
Здесь мы использовали команды для загрузки (findOne), сохранения(save), и удаления(delete) с бд.