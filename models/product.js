const mongoose = require ('mongoose');

const productReviewSchema = mongoose.Schema({
    productName:{
        type: String,
        required: true,
    },
    productPrice:{
        type: String,
        required: true,
    },
    quantity:{
        type: String,
        required: true,
    },
    description:{
        type: String,
        required: true,
    },
    category:{
        type: String,
        required: true,
    },
    subCategory:{
        type: String,
        required: true,
    },
    image:[{
        type: String,
        required: true,
    }],
    popular:{
        type: Boolean,
        required: true,
    },
    recommended:{
        type: Boolean,
        required: false,
    },
});

const Product =mongoose.model("Product",productReviewSchema);
module.exports = Product;
