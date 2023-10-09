require('dotenv').config();
const express = require('express');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/user_model');
const authMiddleware = require('../middlewares/auth_middleware');

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

        const encryptedPassword =await bcryptjs.hash(password,8); //8 is salt added to hashing to encrypt, (not a length)

        let user = new User({ name, email, password:encryptedPassword});
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});
 
//SignIn Route
authRouter.post('/api/signin', async (req, res)=>{
    try{
        const {email, password} = req.body;
        
        const user = await User.findOne({ email });
        if(!user){
            return res.status(400).json({msg: 'User with this mail doesn\'t exits'});
        }

        //match current password with hashed password in mongo using bcryptjs compare func: return true if matched
        const isMatch = await bcryptjs.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg: 'password didn\'t matched'});
        }

        //creating token for user to say this is valid user not hacker or someone else
        //we need userid to sign with and secretkey to generate token , this key is used to verify user
        const token = jwt.sign({id: user._id}, process.env.jwtSecret_KEY);

        

        //what to send : token will be stored in memory of user, and user is needed to send to show homepage and all other related stuffs
        res.json({token, ...user._doc}); //...user is object destructuring ._doc give exact info of user : check diffrence in postman user has so much unneccessary infor while user._doc has needed info
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

//validate token
authRouter.post('/isValidToken',async (req, res)=>{
    try{
        const token = req.header('x-auth-token');
        //if token is null ?
        if(!token) return res.json(false);

        const verified = jwt.verify(token, process.env.jwtSecret_KEY);
        //if token is not valid from jwt verification
        if(!verified) return res.json(false);

        //if however token is valid, but does user exists in database with that token?
        const user = await User.findById(verified.id); //jwt has stored with id, so token is valid, get its id
        if(!user) return res.json(false);

        return res.send(true);
    }catch(err){
        res.status(500).json({error: err.message});
    }
});

//using middleware auth
authRouter.get('/', authMiddleware, async (req,res)=>{
    try{
        const user = await User.findById(req.userId);
        res.json({...user._doc, token:req.token});
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

//Uploading user avatar
authRouter.post('/api/user-avatar', authMiddleware, async (req, res) =>{
    try{
        let user = await User.findById(req.userId);
        user.avatar = req.body.avatar;
        await user.save();
        res.status(200).json({msg: "User Avatar Uploaded!"});
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

module.exports = authRouter;