const mongoose = require("mongoose");

const connection = mongoose.createConnection("mongodb://127.0.0.1:27017/to_do_app").on("open",()=>{
    console.log("mongodb connected");
}).on('error',()=>{
    console.log("mongodb connnection error");
});

module.exports = connection;
