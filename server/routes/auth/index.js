const Router = require('express').Router();

Router.get('/signup', (req, res)=>{
    res.send("signup");
})
Router.get('/login', (req, res)=>{
    res.send("login");
})

module.exports = Router;