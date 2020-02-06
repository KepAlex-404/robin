require('dotenv').config();

const db = {
	host: process.env.DB_HOST,
	port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
	database: process.env.DB_DB,
	debug: true
};

const mysql = require('mysql');
const pool = mysql.createPool(db);

console.time('first query')
pool.query('SELECT 1 + 1 AS solution', (error, results, _fields) => {
	if (error) throw error;

	console.log('The solution is: ', results[0].solution);

	console.timeEnd('first query')
});
