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

connection.query("SHOW TABLES", (err, result) => {
  let tableExists = result.filter(table => table['Tables_in_' + process.env.MYSQL_DATABASE] == "Users");

  //If Users Table does exists it will return else will create it.
  if (tableExists.length != 0) return;

  connection.query("CREATE TABLE Users(Name VARCHAR(20) NOT NULL, UserID VARCHAR(20) NOT NULL PRIMARY KEY, Password VARCHAR(20) NOT NULL, Phone INT(10) UNIQUE)")
  console.log("Users Table Create as it didn't existed!");
})

//  CREATE TABLE Users(Name VARCHAR(20) NOT NULL, UserID VARCHAR(20) NOT NULL PRIMARY KEY, Password VARCHAR(20) NOT NULL, Phone INT(10) UNIQUE);

module.exports = connection;