const mongoose = require("mongoose");

const bannerSchema = mongoose.Schema({
    movieId: {
        type: String,
        required: true
    },
    imageUrl: {
        type: String,
        required: true
    },
}, {timestamps: true});

module.exports = mongoose.model("Banner", bannerSchema);