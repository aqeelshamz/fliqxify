const express = require("express");
const router = express.Router();
const joi = require("joi");
const axios = require("axios");
const Review = require("../models/Review");
const User = require("../models/User");
const { validate } = require("../middlewares/validate");
const Del = require("../models/Del");
const multer = require("multer");
const Movie = require("../models/Movie");

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
  console.log(req.body);
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
      email: user.email,
    });

    await newReview.save();
    return res.send("Review posted");
  } catch (err) {
    console.log(err);
    return res.status(500).send("Something went wrong");
  }
});

router.post("/delete-review", async (req, res) => {
  const schema = joi.object({
    reviewId: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const review = await Review.findById(data.reviewId);
    const delRev = new Del({
      movieId: review.movieId,
      review: review.review,
      email: review.email,
    });
    await delRev.save();
    await Review.findByIdAndDelete(data.reviewId);
    return res.send("Review deleted!");
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

router.post("/like", validate, async (req, res) => {
  const schema = joi.object({
    reviewId: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const review = await Review.findById(data.reviewId);
    let likes = review.likes;
    if (likes.includes(req.user.email)) {
      likes.splice(likes.indexOf(req.user.email), 1);
    } else {
      likes.push(req.user.email);
    }
    await Review.findByIdAndUpdate(data.reviewId, { likes: likes });

    return res.send("Like updated");
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "public");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname);
  },
});

const upload = multer({ storage: storage }).single("file");

router.post("/upload", validate, async (req, res)=>{
  const schema = joi.object({
    movieId: joi.string().required(),
  });

  try{
    const data = await schema.validateAsync(req.body);
    upload(req, res, async (err)=>{
      if(err){
        return res.sendStatus(500);
      }

      await Movie.findByIdAndUpdate(data.movieId, {movieFile: req.file.filename});
      res.send(req.file);
    });
  }
  catch(err){
    return res.status(500).send("Something went wrong");
  }
})

module.exports = router;
