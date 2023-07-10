const express = require('express');
const bcrypt = require('bcryptjs');
const User = require('../models/user');

const authRouter = express.Router(); //express() is initialization which we have to listen on port which is done in index.js file. Router() is used to create differentiable routes

//SignUp Route
authRouter.post('/api/signup', async (req, res) => {
    //1.get data from client 2.store in database 3.acknowledge user
    try {
        const { name, email, password } = req.body; //object destructure of req.body

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with same email already exists" });
        }
        if (password.length < 6) {
            return res.status(400).json({ msg: "Password is too short!" });
        }

        const encryptedPassword =await bcrypt.hash(password,8); //8 is salt added to hashing to encrypt, (not a length)

        let user = new User({ name, email, password:encryptedPassword });
        user = await user.save();
        res.send(user);
    } catch (e) {
        res.status(500).send({ error: e.message });
    }
});

module.exports = authRouter;