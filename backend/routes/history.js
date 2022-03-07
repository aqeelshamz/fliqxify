const router = require("express").Router();
const { validate } = require("../middlewares/validate");
const joi = require("joi");
const History = require("../models/History");

router.get("/", validate, async (req, res) => {
  return res.send(await History.find({ createdBy: req.user._id }));
});

router.post("/continue-watching", async (req, res) => {
  const schema = joi.object({
    movieId: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    return res.send(
      await History.find({ movieId: data.movieId, createdBy: req.user._id })
    );
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

router.post("/", validate, async (req, res) => {
  const schema = joi.object({
    movieId: joi.string().required(),
    duration: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const newHistory = new History({
      movieId: data.movieId,
      duration: data.duration,
      createdBy: req.user._id,
    });

    return res.send(await newHistory.save());
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

module.exports = router;
