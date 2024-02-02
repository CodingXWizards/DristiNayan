const Router = require('express').Router();
const { body, validationResult } = require('express-validator');
const mysql = require('../db');

const multer = require('multer');
const upload = multer({storage: multer.memoryStorage()});

Router.
    get('/', (req, res) => {
        try {
        } catch (error) {

        }
    })

    .post('/add', upload.single('image'), (req, res) => {
        try {
            let errors = validationResult(req);
            if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });

            if(!req.file) return res.status(400).send('No file uploaded');

            const imageBlob = req.file.buffer;

            const { name, crimeHistory, place, date, time } = req.body;
            mysql.query("INSERT INTO Criminals(Name, Image, Crime_History, Place, Date, Time) VALUES (?, ?, ?, ?, ?, ?)", [name, imageBlob, crimeHistory, place, date, time], (err, result) => {
                if (err) return res.status(500).json({ "Error": err });
                res.status(200).send("Success");
            });
        } catch (error) {
            console.error(error);
        }
    })

module.exports = Router;