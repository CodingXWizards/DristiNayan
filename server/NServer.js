const express = require("express");
const App = express();
const CORS = require("cors");
const BodyParser = require('body-parser');
const auth = require("./routes/auth/index");

App.use(CORS());
App.use(express.json());

// Parse application/json
App.use(BodyParser.json());
// Parse application/json
App.use(BodyParser.urlencoded({ extended: false }));

//Routes
App.use("/auth", auth);

App.listen(5000, () => {
  console.log("Dristi Server Running at http://localhost:5000");
});
