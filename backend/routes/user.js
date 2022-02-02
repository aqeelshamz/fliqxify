const express = require("express");
const router = express.Router();
const joi = require("joi");
const User = require("../models/User");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

router.get("/", (req, res) => {
  res.send("Users");
});

router.post("/register", (req, res) => {
  const schema = joi.object({
    name: joi.string().required(),
    email: joi.string().email().required(),
    password: joi.string().required(),
  });

  try {
    const data = schema.validateAsync(req.body);
    const passwordString = data.password;
    const salt = bcrypt.genSalt(10);
    const hashedPassword = bcrypt.hash(passwordString, salt);
    const newUser = new User({
      name: data.name,
      email: data.email,
      password: hashedPassword,
      profilePic: "",
    });
    await newUser.save();
    return res.send("User created!");
  } catch (e) {
    return res.status(500).send("Something went wrong");
  }
});

router.post("/login", (req, res) => {
  const schema = joi.object({
    email: joi.string().email().required(),
    password: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const user = await User.findOne({ email: data.email });
    if (!user) return res.status(401).send("Incorrect email or password");

    const checkPass = await bcrypt.compare(data.password, user.password);

    if (!checkPass) return res.status(401).send("Incorrect email or password");

    const token = jwt.sign(user.email, process.env.TOKEN_SECRET);

    await User.updateOne({ email: data.email }, { token: token });
    return await User.findOne({ email: data.email });
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

module.exports = router;