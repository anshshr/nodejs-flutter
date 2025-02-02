const { Error } = require("mongoose");
const userService = require("../services/user_services");

exports.register = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const succes_response = userService.register_user(email, password);

        res.json({ status: true, succes: "user created succesfully" });
    }
    catch (err) {
        throw err;
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const user =  await userService.check_user(email);

        if (!user) {
            throw new Error("user dosen't exist");
        }

        const ismatch = await user.comparePassword(password);

        if (!ismatch) {
            throw new Error("invalid password");
        }

        let token_data = {_id: user._id, email: user.email,};

        const token = userService.generate_token(token_data,"ansh","10h");

        res.status(200).json({status : true , token : token})
    }
    catch (err) {
        throw err;
    }
}