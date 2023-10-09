const jwt = require('jsonwebtoken')
require('dotenv').config()
const User = require('../models/user_model')

const adminMiddleware = async (req, res, next)=>{
    try{
        const token = req.header('x-auth-token')
        if(!token){
            return res.status(401).json({msg: 'No auth token!, Access denied'})
        }

        const verified = jwt.verify(token, process.env.jwtSecret_KEY)
        if(!verified){
            return res.status(401).json({msg: "Not a valid token, Access denied"})
        }

        const user = await User.findById(verified.id);

        if(user.type !== 'admin'){
            return res.status(401).json({msg : "Not authorized, Access denied"})
        }

        req.userId = verified.id
        req.token = token
        next();
    } catch (e){
        res.status(500).json({error: e.message});
    }
}

module.exports = adminMiddleware;

