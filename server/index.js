//Imports from packages
require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');

//Imports from other files
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

//Init
const app = express(); //initializing express - it is done only once in app
const port  = process.env.PORT || 3000;
const MongoDB_Key = process.env.MongoDB_KEY;

//Middlewares
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//Connections
mongoose.connect(MongoDB_Key).then(()=>{
    console.log("Connected to MongoDb");
}).catch( e => {
    console.log(e);
});


app.listen(port,'0.0.0.0', ()=>{
    console.log("server started on "+port);
});