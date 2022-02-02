const mongoose = require("mongoose");

const planSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    month: {
        type:Number,
        required: true,
    },
    features: {
        type: Array,
        required: true,
        default: []
    },
});

module.exports = mongoose.model("Plan", planSchema);