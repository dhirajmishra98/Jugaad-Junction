const express = require('express');
const Product = require('../models/product_model');
const authMiddleware = require('../middlewares/auth_middleware');

const productRouter = express.Router();

productRouter.get('/api/get-product-by-category', authMiddleware, async (req, res) => {
    try {
        let products = await Product.find({ 'category': req.query.category });
        res.status(200).json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

productRouter.get('/api/products', authMiddleware, async (req, res) => {
    try {
        let products = await Product.find({});
        res.status(200).json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

productRouter.get('/api/products/search/:searchQuery', authMiddleware, async (req, res) => {
    try {
        let products = await Product.find({ name: { $regex: req.params.searchQuery, $options: "i" }, },);
        res.status(200).json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

productRouter.post('/api/product/rating', authMiddleware, async (req, res)=>{
    try{
        const {productId, rating} = req.body;
        let product = await Product.findById(productId);

        //find in product rating list, if current user is provided rating, it means we rated again, so delete his prev rating and push new
        for(let i=0;i<product.ratings.length;i++){
            if(product.ratings[i].userId == req.userId){
                product.ratings.splice(i, 1);
                break;
            }
        }

        let newRating = {
            userId: req.userId,
            rating,
        }

        product.ratings.push(newRating);
        product = await product.save();
        res.status(200).json(product); 

    } catch(e){
        res.status(500).json({error: e.message});
    }
});

module.exports = productRouter;