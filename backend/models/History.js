const mongoose = require("mongoose");

const historySchema = mongoose.Schema(
  {
    movieId: {
      type: String,
      required: true,
    },
    duration: {
      type: String,
      required: true,
    },
    createdBy: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("History", historySchema);
