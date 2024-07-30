const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors'); 
const userRouter = require('./routes/user.routes');
const app = express();

app.use(bodyParser.json());
app.use(cors()); 

app.use('/', userRouter);

module.exports = app;
