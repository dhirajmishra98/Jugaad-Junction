const mongoose = require('mongoose');
const { productSchema } = require('./product_model');

const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (val) => {
                const emailRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
                return val.match(emailRegex);
            },
            message: "Enter a valid email address",
        }
    },
    password: {
        required: true,
        type: String,
        validate : {
            validator : (val)=>{
                // return val.length >= 6;
                return typeof val === 'string' && val.length >= 6;
            },
            message : "Password is too short!"
        }
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    avatar:{
        type: String,
    },
    cart:[
        {
            product: productSchema,
            quantity:{
                type: Number,
                required: true,
            }
        }
    ],
    
});

const User = mongoose.model('User', userSchema);
module.exports = User;