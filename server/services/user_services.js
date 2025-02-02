const usermodel = require("../models/user_model")
const jwt = require("jsonwebtoken");

class user_services{
    static async register_user(email,password){
        try{
            const create_user = new usermodel({email,password});
            await create_user.save();
        }
        catch(err){
            throw err;
        }
    }

    static async check_user(email){
        try{
            return await usermodel.findOne({email});
        }
        catch(err){
            throw err;
        }
    }


    static async generate_token(token_data,secret_key,jwt_expiry){
        return jwt.sign(token_data,secret_key,{expiresIn : jwt_expiry});
    }   
}


module.exports = user_services;