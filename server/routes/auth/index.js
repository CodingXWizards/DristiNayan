const Router = require('express').Router();
const bcrypt = require('bcrypt');
const { body, validationResult } = require('express-validator');
const JWT = require('jsonwebtoken');
const dotenv = require('dotenv');
const mysql = require('../../db');
dotenv.config();
const secretKey = process.env.JWT_SECRET;

Router
    // Create User
    .post('/signup', [
        body('name', 'Please enter a name more than 3 letter').isLength({ min: 3 }),
        body('userId', "Please enter a valid id").isLength({ min: 3 }),
        body('password', "Please enter a password more than 5 letters").isLength({ min: 5 }),
    ], async (req, res) => {
        try {
            let errors = validationResult(req);
            if (!errors.isEmpty()) return res.status(400).json({ erros: errors.array() })
            mysql.query("SELECT * FROM Users WHERE UserID = ?", [req.body.userId], async (err, result) => {
                if (err)
                    res.status(500).json({ "Error": err });
                console.log(result)
                if (result.length != 0) return res.status(400).send("A User exists with this UserID")
                const salt = await bcrypt.genSalt(10);
                const secPassword = await bcrypt.hash(req.body.password, salt);
                mysql.query("INSERT INTO Users(Name, UserID, Password) VALUES (?, ?, ?)", [req.body.name, req.body.userId, secPassword], (err, result) => {
                    if (err)
                        return res.status(500).json({ "Error:": err });
                    const data = { user: { userid: req.body.userId } };
                    const authToken = JWT.sign(data, secretKey);
                    res.status(200).json({ user: { name: req.body.name, userID: req.body.userId, password: secPassword }, authToken });
                })
            })

        } catch (error) {
            console.error(error);
            res.status(500).send("Internal Server Error!");
        }
    })

    //Login User
    .post('/login', (req, res) => {
        try {
            mysql.query("SELECT * FROM Users WHERE UserID=?", [req.body.userId], async (err, result) => {
                const user = result[0];
                if (!user) return res.status(404).send("There exists no user with that username")

                const checkPassword = await bcrypt.compare(req.body.password, user.Password);

                if (!checkPassword) return res.status(400).send("Please enter correct password!");

                const data = { user: { id: user.UserID } };
                const authToken = JWT.sign(data, secretKey);
                const { Password, ...others } = user;
                res.status(200).json({ user: others, authToken });
            })
        } catch (error) {
            console.error(error);
            res.status(500).send("Internal Server Error!");
        }
    })

module.exports = Router;