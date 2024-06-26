const mongoose = require("mongoose");

const userSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
    },
    password: {
      type: String,
      required: true,
    },
    profilePic: {
      type: String,
      required: false,
      default: "",
    },
    type: {
      type: String,
      required: true,
    },
    token: {
      type: String,
      required: false,
      default: "",
    },
    plan: {
      type: Number,
      required: true,
    },
    watchlist: {
      type: Array,
      default: []
    },
    continueWatching: {
      type: Array,
      default: []
    },
    likedMovies: {
      type: Array,
      default: []
    }, 
  },
  { timestamps: true }
);

module.exports = mongoose.model("User", userSchema);
