const mongoose = require("mongoose");

const reviewSchema = mongoose.Schema(
  {
    movieId: {
      type: String,
      required: false,
    },
    review: {
      type: String,
      required: true,
    },
    profilePic: {
      type: String,
      required: true,
    },
    username: {
      type: String,
      required: true,
    },
    likes: {
      type: Array,
      required: false,
      default: [],
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Review", reviewSchema);
