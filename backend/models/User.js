const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
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
    required: true,
  },
  token: {
    type: String,
    required: true,
  },
  plan: {
    type: String,
    required: false,
  },
});

module.exports = mongoose.model("User", userSchema);
