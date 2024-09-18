const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const authRouter = express.Router();

authRouter.post('/api/signup',async (req,res)=>{
    try{
        const {fullName,email,password} = req.body;
        const exisitingEmail = await User.findOne({email});
        if(exisitingEmail){
            return res.status(400).json({msg:"user with the same email already exist! "});
            //400 status used for the client error not the server 
        }
        else{

        const salt = await bcrypt.genSalt(10);
        const hashPassword =await bcrypt.hash(password,salt);
            //let is used to declare block-scoped variables in JavaScript. 
            //This means the user variable is only accessible within the block it is defined in.
            let user = new User({fullName,email,password:hashPassword});
            user = await user.save();
            res.json({user});
        }
    }
    catch(e){
        //500 status code returns that the internal server error
        res.status(500).json({error:e.message});
    }
});

//signin user 

authRouter.post("/api/signin",async(req,res)=>{
   try {
    const {email,password }= req.body;
    const findUser = await User.findOne({email});
    if(!findUser){
        return res.status(400).json({msg:"User not found with this email"});
    } 
    else{
        const isMatch =  await bcrypt.compare(password,findUser.password);
        if(!isMatch){
            return res.status(400).json({msg:"Incorrect Password"});
        }
        else{
            const token = jwt.sign({id:findUser._id},"passwordKey");

            const {password, ...userWithoutPassword} = findUser._doc;
            res.json({token, user: userWithoutPassword});

        }
    }   
    }
   catch (error) {
    res.status(500).json({error:e.message});
   } 
});


module.exports = authRouter;
