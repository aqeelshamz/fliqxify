const mongoose = require("mongoose");

const movieSchema = mongoose.Schema(
  {
    movieId: {
      type: String,
      required: true,
    },
    movieFile: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Movie", movieSchema);
