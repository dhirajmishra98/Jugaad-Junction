const express = require('express');
const authMiddleware = require('../middlewares/auth_middleware');
const { Product, productSchema } = require('../models/product_model');
const User = require('../models/user_model');
const Order = require('../models/order_model');

const userRouter = express.Router();


userRouter.post('/api/add-to-cart', authMiddleware, async(req, res)=>{
    try{
        const {productId} = req.body;
        const product = await Product.findById(productId);
        let user = await User.findById(req.userId)

        //if user cart is empty, its first time user adding to cart
        if(user.cart.length==0){
            user.cart.push({product, quantity:1});
        }else{
            //there are some product in cart, lets find if select product is already in cart or not
            let isProductFound = false;
            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){
                    //it confirms selected product is already in cart
                    isProductFound = true;
                }
            }

            //find selected product from cart array of user model and increase its quantity by 1
            if(isProductFound){
                let productFound = user.cart.find( (cartProduct) => cartProduct.product._id.equals(product._id));
                productFound.quantity += 1;
            }else{
                //new item to cart which is not empty
                user.cart.push({product, quantity: 1});
            }
        }

        //update user with thier cart and save and return updated user 
        user = await user.save();
        res.status(200).json(user);
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

userRouter.delete('/api/remove-from-cart/:productId', authMiddleware, async(req, res)=>{
    try{
        const {productId} = req.params;
        const product = await Product.findById(productId);
        let user = await User.findById(req.userId);

        for(let i=0;i<user.cart.length;i++){
            if(user.cart[i].product._id.equals(product._id)){
                if(user.cart[i].quantity==1){
                    user.cart.splice(i,1);
                }else{
                    user.cart[i].quantity -= 1;
                }
            }
        }
        
        user = await user.save();
        res.status(200).json(user);
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

userRouter.post('/api/save-user-address', authMiddleware, async(req, res)=>{
    try{
        const {userAddress} = req.body;
        let user = await User.findById(req.userId);
        user.address = userAddress;
        user = await user.save();
        res.status(200).json(user);
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

userRouter.post('/api/order', authMiddleware, async (req, res)=>{
    try{
        const {cart, totalPrice, address} = req.body;
        let products = [];
        for(let i=0;i<cart.length;i++){
            let product = await Product.findById(cart[i].product._id);
            if(product.quantity >= cart[i].quantity){
                product.quantity -= cart[i].quantity;
                products.push({product, quantity: cart[i].quantity});
                await product.save();
            }else{
                return res.status(400).json({error: `${product.name} is out of stock`});
            }
        }

        let user = await User.findById(req.userId);
        user.cart = [];
        user = await user.save();

        let order = new Order({
            products,
            totalPrice,
            address,
            userId: req.userId,
            orderedAt: new Date().getTime(),
        });

        order = await order.save();
        res.status(200).json(order);
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

userRouter.get('/api/orders/me', authMiddleware, async(req, res)=>{
    try{
        const orders = await Order.find({userId: req.userId});
        res.status(200).json(orders);
    } catch(e){
        res.status(500).json({error: e.message});
    }
});

module.exports = userRouter;