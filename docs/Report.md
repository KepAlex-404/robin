# TypeORM в связке с постгрессом
## 1. Почему тайпорм такой классный
We’ll use TypeORM to manage our database schema. What is nice about TypeORM is, that it allows you to model your data entities in type save code (Typescript) and then is able to apply / sync these models into the table structure in your database. (By the way, this not only works with PostgreSQL databases, but also other databases, find more info on which databases are supported in the TypeORM docs)

## 2. Что такое тайп орм
TypeORM is an ORM that can run in NodeJS, Browser, Cordova, PhoneGap, Ionic, React Native, NativeScript, Expo, and Electron platforms and can be used with TypeScript and JavaScript (ES5, ES6, ES7, ES8). Its goal is to always support the latest JavaScript features and provide additional features that help you to develop any kind of application that uses databases — from small applications with a few tables to large scale enterprise applications with multiple databases.

TypeORM supports both Active Record and Data Mapper patterns, unlike all other JavaScript ORMs currently in existence, which means you can write high quality, loosely coupled, scalable, maintainable applications the most productive way.
## 3. В чем разница тайп орм и другого говна

## 4. Почему мы выбрали именно postgress
PostgreSQL isn't just relational, it's object-relational. This gives it some advantages over other open source SQL databases like MySQL, MariaDB and Firebird.

A fundamental characteristic of an object-relational database is support for user-defined objects and their behaviors including data types, functions, operators, domains and indexes. This makes PostgreSQL extremely flexible and robust. Among other things, complex data structures can be created, stored and retrieved. In some of the examples below you'll see nested and composite structures which standard RDBMS' don't support.

There's an extensive list of data types that PostgreSQL supports. Besides the numeric, floating-point, string, boolean and date types you'd expect (and many options within these), PostgreSQL boasts uuid, monetary, enumerated, geometric, binary, network address, bit string, text search, xml, json, array, composite and range types, as well as some internal types for object identification and log location. To be fair, MySQL, MariaDB and Firebird each have some of these to varying degrees, but only PostgreSQL supports all of them.

PostgreSQL has a lot of capability. Built using an object-relational model, it supports complex structures and a breadth of built-in and user-defined data types. It provides extensive data capacity and is trusted for its data integrity. You may not need all of the advanced features we've reviewed here for storing data, but since data needs can evolve quickly, there is undoubtedly clear benefit to having it all at your fingertips.


## 5. Как подключить это говно в проект и где дока
Okay cool, Let’s get started by generating our project with these few lines:
npm i -g @nestjs/cli
nest new project-name
more on the NestJS and it’s CLI here:https://docs.nestjs.com/

### Connecting NestJS to your database
Like for everything, there is already an NPM module that helps you to hook the NestJS project to your database. Let’s add TypeORM support to our project by using the pre-build NestJS-to-TypeORM module.
You can add the needed modules like this:
npm install --save @nestjs/typeorm typeorm pg: 

More info can be found in the NestJS docs: https://docs.nestjs.com/techniques/database
and TypeORM docs: https://typeorm.io/#/


## 6. Пример, где всё это юзая, создаём ентити, сервис или что-то ещё

### Create a model
Working with a database starts from creating tables. How do you tell TypeORM to create a database table? The answer is - through the models. Your models in your app are your database tables.

For example, you have a Photo model:

export class Photo {
    id: number;
    name: string;
    description: string;
    filename: string;
    views: number;
    isPublished: boolean;
}
And you want to store photos in your database. To store things in the database, first you need a database table, and database tables are created from your models. Not all models, but only those you define as entities.

### Create an entity

Entity is your model decorated by an @Entity decorator. A database table will be created for such models. You work with entities everywhere with TypeORM. You can load/insert/update/remove and perform other operations with them.

Let's make our Photo model as an entity:

import {Entity} from "typeorm";

@Entity()
export class Photo {
    id: number;
    name: string;
    description: string;
    filename: string;
    views: number;
    isPublished: boolean;
}
Now, a database table will be created for the Photo entity and we'll be able to work with it anywhere in our app. We have created a database table, however what table can exist without columns? Let's create a few columns in our database table.

### Creating a primary column

Each entity must have at least one primary key column. This is a requirement and you can't avoid it. To make a column a primary key, you need to use @PrimaryColumn decorator.

import {Entity, Column, PrimaryColumn} from "typeorm";

@Entity()
export class Photo {

    @PrimaryColumn()
    id: number;

    @Column()
    name: string;

    @Column()
    description: string;

    @Column()
    filename: string;

    @Column()
    views: number;

    @Column()
    isPublished: boolean;
}