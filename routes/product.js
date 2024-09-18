const express = require('express');
const Product = require('../models/product');

const productRouter = express.Router();

// Route to create a new product
productRouter.post('/api/product', async (req, res) => {
    try {
        const { productName, productPrice, quantity, description, category, subCategory, image } = req.body;
        const product = new Product({ productName, productPrice, quantity, description, category, subCategory, image });
        await product.save();
        return res.status(201).send(product);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// Route to get popular products
productRouter.get('/api/popular-products', async (req, res) => {
    try {
        const products = await Product.find({ popular: true });
        if (!products || products.length === 0) {
            return res.status(404).json({ msg: "No popular products found" });
        } else {
            return res.status(200).json(products);
        }
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

productRouter.get('/api/recommended-products', async (req, res) => {
    try {
        const products = await Product.find({ recommended: true });
        if (!products || products.length === 0) {
            return res.status(404).json({ msg: "No recommended products found" });
        } else {
            return res.status(200).json(products);
        }
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = productRouter;
