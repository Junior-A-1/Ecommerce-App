const express = require('express');
const subCategory = require('../models/sub_category');
const { message } = require('statuses');
const subcategoryRouter = express.Router();

subcategoryRouter.post('/api/subcategory',async(req,res)=>{
    try {
        const {categoryId,categoryName,image,subCategoryName} = req.body;
        const sub_category = new subCategory({categoryId,categoryName,image,subCategoryName});
        await sub_category.save();
        return res.status(201).send(sub_category);
    } catch (e) {
        res.status(500).json({error:e.message});
    }
});

subcategoryRouter.get('/api/subcategory',async(req,res)=>{
    try {
        const subcategories = await subCategory.find();
        return res.status(200).json(subcategories);
    } catch (error) {
        res.status(500).json({error:e.message});
        
    }
});

subcategoryRouter.get('/api/category/:categoryName/subcategory',async(req,res)=>{
    try {
        const {categoryName} = req.params;
        const subcategories = await subCategory.find({categoryName:categoryName});
        if(!subcategories||subcategories.length == 0){
            return res.status(404).json({msg: "Empty Sub Categories!"});
        }
        else{
            return res.status(200).json(subcategories);
        }
    } catch (e) {
        
    res.status(500).json({error:e.message});
    }
});

module.exports = subcategoryRouter;