const express = require('express');
const adminMiddleware = require('../middlewares/admin_middleware');
const {Product} = require('../models/product_model');
const Order = require('../models/order_model');
const adminRouter = express.Router();

//Add Product
adminRouter.post('/admin/add-product', adminMiddleware, async (req, res)=>{
    try{
        const {name, description, category, price, quantity, images } = req.body;
        let product = new Product({
            name,
            description,
            category,
            price,
            quantity,
            images,
        });

        product = await product.save();
        res.status(200).json(product);
    } catch(e){
        res.status(500).json({error: e.message});
    }
})

//Get all product
adminRouter.get('/admin/get-products', adminMiddleware, async (req, res)=>{
    try{
        const products = await Product.find({});
        res.status(200).json(products);
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

//Remove a product
adminRouter.post('/admin/remove-product', adminMiddleware, async (req, res)=>{
    try{
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

//Get orders
adminRouter.get('/admin/get-orders', adminMiddleware, async (req, res)=>{
    try{
        let orders = await Order.find({});
        res.status(200).json(orders);
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

//Change order status
adminRouter.post('/admin/change-order-status', adminMiddleware, async (req, res)=>{
    try{
        const {id, status} = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.status(200).json(order);
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

module.exports = adminRouter;
