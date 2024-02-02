const express = require("express");
const App = express();
const CORS = require("cors");
const BodyParser = require('body-parser');
const DB = require('./db');
const auth = require("./routes/auth/index");
const criminal = require("./routes/criminal");

App.use(CORS());
App.use(express.json());

// Parse application/json
App.use(BodyParser.json({ limit: '100mb' }));
// Parse application/json
App.use(BodyParser.urlencoded({ extended: false, limit: '50mb' }));

//Routes
App.use("/auth", auth);
App.use("/criminal", criminal);
App.use('/', (req, res) => {
  DB.query('SELECT * FROM Users', (error, results) => {
    if (error) {
      res.status(500).send('Error retrieving data from the Databse');
      return;
    }
    res.status(200).json(results);
  })
})

App.listen(5000, () => {
  console.log("Dristi Server Running at http://localhost:5000");
});
