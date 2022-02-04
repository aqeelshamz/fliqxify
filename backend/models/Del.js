const mongoose = require("mongoose");

const delReviewSchema = mongoose.Schema(
  {
    movieId: {
      type: String,
      required: false,
    },
    review: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("DelReview", delReviewSchema);
