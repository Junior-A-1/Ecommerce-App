    const express = require('express');
    const mongoose = require('mongoose');
    const authRouter = require('./routes/auth');
    const bannerRouter = require('./routes/banner');
    const categoryRouter = require('./routes/category');
    const subcategoryRouter = require('./routes/sub_category');
    const productRouter = require('./routes/product');
    const productReviewRouter = require('./routes/rating_review');
    const vendorRouter = require('./routes/vendor');
    const cors = require('cors');//"CROSS ORIGIN RESOURCE SHARING" it is a security feature
    //implemented by we browsers that restricts web pages from making req to different 
    //domain origin other than the one served 
    //By default browsers block stores cross-origin req to prevent malicious websites  from making 
    //unauthorized req and by adding CHORS we are simply relaxing the security applied to an API by
    //enabiling Cross-origin req


    const PORT =3000;


    const app = express(); 

    const DB = "mongodb+srv://adanuddin6:adan10011@cluster0.klqkbly.mongodb.net/"


    app.use(express.json());
    app.use(cors());//enable cors for all routes and origin OR (domain)
    app.use(bannerRouter);
    app.use(authRouter);
    app.use(categoryRouter);
    app.use(subcategoryRouter);
    app.use(productRouter);
    app.use(productReviewRouter);
    app.use(vendorRouter);




    mongoose.connect((DB)).then(()=>{
        console.log('mongodb connected');
    });

    app.listen(PORT,"0.0.0.0",function(){
        console.log(`server is running on ${PORT}`);
    })
