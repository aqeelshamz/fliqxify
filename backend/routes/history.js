const router = require("express").Router();
const { validate } = require("../middlewares/validate");
const joi = require("joi");
const History = require("../models/History");
const { default: axios } = require("axios");

router.get("/", validate, async (req, res) => {
  const history = await History.find({ createdBy: req.user._id });
  const continueWatching = [];
  for (const item of history) {
    var response = await axios.get(
      `https://api.themoviedb.org/3/movie/${item.movieId}?api_key=3794a566770835ffed011b687794a132&language=en-US`
    );
    continueWatching.push({movie: response.data, duration: item.duration});
  }

  return res.send(continueWatching);
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
