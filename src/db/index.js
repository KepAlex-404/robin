const mongoose = require('mongoose');
const mysql = require('mysql');

const initMongo = logger => mongoUrl => {
  mongoose.connect(mongoUrl, {
    useCreateIndex: true,
    useFindAndModify: false,
    useNewUrlParser: true,
    useUnifiedTopology: true,
  }).catch(e => {
		logger.error(e.toString());
	});

  mongoose.connection.once('open', () => {
    logger.db('Connected to Mongo');
	});

	return mongoose;
};

const initMySQL = logger => mysqlConfig => {
	const pool = mysql.createPool(mysqlConfig);

	pool.getConnection(e => {
		e ?
			logger.error('MySQL ' + e.toString()) :
			logger.db('Connected to MySQL');
	});

	return pool;
}

module.exports = logger => ({
	initMongo: initMongo(logger),
	initMySQL: initMySQL(logger),
});
