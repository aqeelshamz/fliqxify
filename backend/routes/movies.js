const express = require("express");
const router = express.Router();
const joi = require("joi");
const axios = require("axios");
const Review = require("../models/Review");
const User = require("../models/User");
const { validate } = require("../middlewares/validate");

router.post("/trailer", async (req, res) => {
  const schema = joi.object({
    movieId: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const url = `https://api.themoviedb.org/3/movie/${data.movieId}/videos?api_key=3794a566770835ffed011b687794a132&language=en-US`;
    const config = {
      url: url,
      method: "get",
    };
    axios(config)
      .then((response) => {
        console.log(response.data);
        let videos = response.data.results;
        let trailerUrl = "";
        let thumbnail = "";
        for (var video of videos) {
          if (video.name.toString().toLowerCase().includes("trailer")) {
            trailerUrl = "https://youtube.com/watch?v=" + video.key;
            thumbnail = `https://img.youtube.com/vi/${video.key}/0.jpg`;
            break;
          }
        }
        return res.json({ url: trailerUrl, thumbnail: thumbnail });
      })
      .catch((err) => {
        return res.status(500).send("Something went wrong");
      });
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

router.post("/get-reviews", async (req, res) => {
  const schema = joi.object({
    movieId: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    return res.send(
      await Review.find({ movieId: data.movieId }).sort({ _id: -1 })
    );
  } catch (err) {
    console.log(err);

    return res.status(500).send("Something went wrong");
  }
});

router.post("/post-review", validate, async (req, res) => {
  const schema = joi.object({
    movieId: joi.string().required(),
    review: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const user = await User.findById(req.user._id);
    const newReview = new Review({
      movieId: data.movieId,
      review: data.review,
      profilePic: user.profilePic,
      username: user.name,
    });

    await newReview.save();
    return res.send("Review posted");
  } catch (err) {
    console.log(err);
    return res.status(500).send("Something went wrong");
  }
});

module.exports = router;
