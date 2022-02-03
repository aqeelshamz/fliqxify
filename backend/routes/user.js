const express = require("express");
const router = express.Router();
const joi = require("joi");
const User = require("../models/User");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const { validate } = require("../middlewares/validate");

router.get("/", (req, res) => {
  res.send("Users");
});

router.post("/register", async (req, res) => {
  const schema = joi.object({
    name: joi.string().required(),
    email: joi.string().email().required(),
    password: joi.string().required(),
    type: joi.string().required().allow("admin", "user"),
    plan: joi.number().required().allow(1, 2, 3),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const passwordString = data.password;
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(passwordString, salt);
    const newUser = new User({
      name: data.name,
      email: data.email,
      password: hashedPassword,
      profilePic: "",
      type: data.type,
      plan: data.plan,
    });
    return res.send(await newUser.save());
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

router.post("/login", async (req, res) => {
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
    return res.send(await User.findOne({ email: data.email }));
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

router.post("/update", validate, async (req, res) => {
  const schema = joi.object({
    name: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    await User.findByIdAndUpdate(req.user._id, { name: data.name });
    return res.send("Updated!");
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

router.get("/profile", validate, async (req, res) => {
  res.send(await User.findById(req.user._id));
});

router.post("/reset-password", validate, async (req, res) => {
  const schema = joi.object({
    currentPassword: joi.string().required(),
    newPassword: joi.string().required(),
    confirmPassword: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const user = await User.findById(req.user._id);
    const checkPass = await bcrypt.compare(data.currentPassword, user.password);

    if (!checkPass) return res.status(401).send("Incorrect email or password");

    if (data.newPassword !== data.confirmPassword) {
      return res.status(401).send("Passwords don't match");
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(data.newPassword, salt);

    await User.findByIdAndUpdate(req.user._id, { password: hashedPassword });
    return res.send("Password changed!");
  } catch (err) {
    console.log(err)
    return res.status(500).send("Something went wrong");
  }
});

module.exports = router;