const mongoose = require('mongoose')

const productSchema = mongoose.Schema({
    name:{
        type: String,
        required: true,
        trim: true,
    },
    description:{
        type: String,
        required: true,
        trim: true,
    },
    category:{
        type: String,
        required: true,
        trim: true,
    },
    price:{
        type: Number,
        required: true,
    },
    quantity:{
        type: Number,
        required: true,
    },
    images:[
        {
            type: String,
            required: true,
        },
    ],
    //rating if implemented
})

const Product = mongoose.model('Product', productSchema)
module.exports = Product