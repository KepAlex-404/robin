const db = require('./test/db');

const pool = db.pool();

pool.query('SELECT * from `test`', (error, results, _fields) => {
	if (error) throw error;
	console.log('The solution is: ', results.map(({id}) => id));
});
