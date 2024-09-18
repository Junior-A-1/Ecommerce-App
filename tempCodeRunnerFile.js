const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const bannerRouter = require('./routes/banner');
const categoryRouter = require('./routes/category');
const subcategoryRouter = require('./routes/sub_category');


const PORT =3000;


const app = express(); 

const DB = "mongodb+srv://adanuddin6:adan10011@cluster0.klqkbly.mongodb.net/"


app.use(express.json());
app.use(bannerRouter);
app.use(authRouter);
app.use(categoryRouter);
app.use(subcategoryRouter);




mongoose.connect((DB)).then(()=>{
    console.log('mongodb connected');
});

app.listen(PORT,"0.0.0.0",function(){
     console.log(`server is running on ${PORT}`);
})
