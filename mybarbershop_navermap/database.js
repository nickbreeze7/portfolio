const mysql = require('mysql2');
//require('dotenv').config();




// Database connection

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '101367',
    database: 'barbershop_test'
});




db.connect(err => {
    if (err) {
        console.error('Error connecting to the database: ' + err.stack);
        return;
    }
    console.log('Connected to database as id ' + db.threadId);
});

module.exports = db;