const mongoose = require("mongoose");
const db = require("../config/db")
const bcrypt = require('bcrypt');

const user_schema = mongoose.Schema({
    name: String,
    email: String,
    password: String,
    age: Number,
});


user_schema.pre("save", async function () {
    try {
        var user = this
        const salt = await (bcrypt.genSalt(10));
        const hash_password = await bcrypt.hash(user.password, salt);
        user.password = hash_password;
        user.save();
    }
    catch (err) {
        console.log(err);
        throw err;
    }
});


user_schema.methods.comparePassword = async function(user_password) {
    try {
        const is_matched = await bcrypt.compare(user_password,this.password);
        return is_matched;
    } catch (error) {
        console.error(error);
        throw error;
    }
}

module.exports = db.model('user', user_schema);