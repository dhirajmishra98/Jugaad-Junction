const jwt = require('jsonwebtoken');
require('dotenv').config();

const auth = async (req, res, next)=>{
    try{
        const token = req.header('x-auth-token');
        if(!token){
            return res.status(401).json({msg: 'No auth token, Access denied!'});
        }

        const verified = jwt.verify(token, process.env.jwtSecret_KEY);
        if(!verified) return res.send(401).json({msg: "Not a valid token, Authorization failed!"});

        req.userId = verified.id;
        req.token = token;
        next();
    }catch(e){
        res.status(500).json({error: e.message});
    }
}

module.exports = auth;