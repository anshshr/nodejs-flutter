const express = require('express');
const app = express();
const db = require("./config/db")
const user_model = require("./models/user_model");
const body_parser = require("body-parser");
const user_router = require('./routes/user_routes');

app.use(body_parser.json());
app.use('/',user_router);

app.get("/" ,function(req,res){
    res.send("hello and welcome");
});



//listening the user 
app.listen(3000);

