const express = require('express');
const Vendor = require('../models/vendor');
const vendorRouter = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

vendorRouter.post('/api/vendor/signup',async (req,res)=>{
    try{
        const {fullName,email,password} = req.body;
        const exisitingEmail = await Vendor.findOne({email});
        if(exisitingEmail){
            return res.status(400).json({msg:"vendor with the same email already exist! "});
            //400 status used for the client error not the server 
        }
        else{

        const salt = await bcrypt.genSalt(10);
        const hashPassword =await bcrypt.hash(password,salt);
            //let is used to declare block-scoped variables in JavaScript. 
            //This means the user variable is only accessible within the block it is defined in.
            let vendor = new Vendor({fullName,email,password:hashPassword});
            vendor = await vendor.save();
            res.json({vendor: vendor});
        }
    }
    catch(e){
        //500 status code returns that the internal server error
        res.status(500).json({error:e.message});
    }
});


vendorRouter.post("/api/vendor/signin",async(req,res)=>{
    try {
     const {email,password }= req.body;
     const findUser = await Vendor.findOne({email});
     if(!findUser){
         return res.status(400).json({msg:"Vendor not found with this email"});
     } 
     else{
         const isMatch =  await bcrypt.compare(password,findUser.password);
         if(!isMatch){
             return res.status(400).json({msg:"Incorrect Password"});
         }
         else{
             const token = jwt.sign({id:findUser._id},"passwordKey");
 
             const {password, ...vendorWithoutPassword} = findUser._doc;
             res.json({token, vendor: vendorWithoutPassword});
 
         }
     }   
     }
    catch (error) {
     res.status(500).json({error:e.message});
    } 
 });

module.exports = vendorRouter;