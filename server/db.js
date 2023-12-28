const mysql = require("mysql");
const dotenv = require('dotenv');
dotenv.config();

const connection = mysql.createConnection({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE,
});


connection.connect((err) => {
  if (err) {
    console.error("Error connecting to database:", err);
    return;
  }
  console.log('Connected to MySQL Database!');
});

//  CREATE TABLE Users(Name VARCHAR(20) NOT NULL, UserID VARCHAR(20) NOT NULL PRIMARY KEY, Password VARCHAR(20) NOT NULL, Phone INT(10) UNIQUE);

module.exports = connection;