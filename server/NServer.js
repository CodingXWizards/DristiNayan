let express = require('express');
let App = express();

App.use('/', (req, res)=>{
    res.send("hello world");
})

App.listen(5000, ()=>{
    console.log("Server Running at http://localhost:5000");
})