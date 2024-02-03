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

App.listen(5000, () => {
  console.log("Dristi Server Running at http://localhost:5000");
});
