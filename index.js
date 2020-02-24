require('dotenv').config();
const logger = require('metalog')({
  path: './log',
  workerId: 1,
  writeInterval: 3000,
  writeBuffer: 64 * 1024,
  keepDays: 1,
});
const db = require('./src/db/')(logger);

db.initMongo(process.env.MONGO);
db.initMySQL({
  host: process.env.MYSQL_HOST,
  port: process.env.MYSQL_PORT,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_MYSQL,
});
