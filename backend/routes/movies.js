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
        console.log(err);
        return res.status(500).send("Something went wrong");
      });
  } catch (err) {
    console.log(err);
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

router.post("/like-review", validate, async (req, res) => {
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
    console.log(err);
    return res.status(500).send("Something went wrong");
  }
});

const videoStorage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "public");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname);
  },
});

// const upload = multer({ storage: storage }).single("file");

const videoUpload = multer({
  storage: videoStorage,
  fileFilter(req, file, cb) {
    // upload only mp4 and mkv format
    if (!file.originalname.match(/\.(mp4|MPEG-4|mkv)$/)) {
      return cb(new Error("Please upload a video"));
    }
    cb(undefined, true);
  },
});

router.post("/upload", videoUpload.single("file"), async (req, res) => {
  try {
    const movieExist = await Movie.findOne({ movieId: req.body.movieId });
    if (movieExist) {
      await Movie.findOneAndUpdate(
        { movieId: req.body.movieId },
        {
          movieFile: req.file.filename,
        }
      );
    } else {
      const newMovie = new Movie({
        movieId: req.body.movieId,
        movieFile: req.file.filename,
      });
      await newMovie.save();
    }

    res.send(req.file);
  } catch (err) {
    console.log(err);
    return res.sendStatus(500);
  }
});

router.post("/video", validate, async (req, res) => {
  const schema = joi.object({
    movieId: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const movie = await Movie.findOne({ movieId: data.movieId });
    if (!movie) {
      return res.send({ videoLink: "" });
    }
    return res.send({
      videoLink: "http://fliqxify-backend.aqeelshamz.com/" + movie.movieFile,
    });
  } catch (err) {
    console.log(err);
    return res.status(500).send("Something went wrong");
  }
});

router.post("/like", validate, async (req, res) => {
  const schema = joi.object({
    movieId: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const user = await User.findById(req.user._id);
    let likedMovies = user.likedMovies;
    if (likedMovies.includes(data.movieId)) {
      likedMovies.splice(likedMovies.indexOf(data.movieId), 1);
    } else {
      likedMovies.push(data.movieId);
    }
    await User.findByIdAndUpdate(req.user._id, { likedMovies: likedMovies });
    return res.send(await User.findById(req.user._id, "likedMovies"));
  } catch (err) {
    console.log(err);
    return res.status(500).send("Something went wrong");
  }
});

router.post("/watchlist", validate, async (req, res) => {
  const schema = joi.object({
    movieId: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const user = await User.findById(req.user._id);
    let watchlist = user.watchlist;
    if (watchlist.includes(data.movieId)) {
      watchlist.splice(watchlist.indexOf(data.movieId), 1);
    } else {
      watchlist.push(data.movieId);
    }
    await User.findByIdAndUpdate(req.user._id, { watchlist: watchlist });
    return res.send(await User.findById(req.user._id, "watchlist"));
  } catch (err) {
    console.log(err);
    return res.status(500).send("Something went wrong");
  }
});

router.post("/movie-user-data", validate, async (req, res) => {
  const schema = joi.object({
    movieId: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const user = await User.findById(req.user._id);
    let userData = {
      isLiked: user.likedMovies.includes(data.movieId),
      inWatchlist: user.watchlist.includes(data.movieId),
    };

    return res.send(userData);
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

router.get("/my-watchlist", validate, async (req, res) => {
  const user = await User.findById(req.user._id);
  console.log(user);
  let watchlistMovies = [];
  for (const movieId of user.watchlist) {
    var response = await axios.get(
      `https://api.themoviedb.org/3/movie/${movieId}?api_key=3794a566770835ffed011b687794a132&language=en-US`
    );
    watchlistMovies.push(response.data);
  }

  watchlistMovies = watchlistMovies.reverse();

  return res.send(watchlistMovies);
});

router.post("/get-download-url", validate, async (req, res) => {
  const schema = joi.object({
    movieId: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const movie = await Movie.findOne({ movieId: data.movieId });
    var movieData = await axios.get(
      `https://api.themoviedb.org/3/movie/${data.movieId}?api_key=3794a566770835ffed011b687794a132&language=en-US`
    );
    if (!movie) return res.status(404).send("File not found");
    const url = "https://fliqxify-backend.aqeelshamz.com/" + movie.movieFile;
    console.log(movieData.title);
    console.log(movieData.poster_path);
    return res.json({
      title: movieData.title,
      poster: movieData.poster_path,
      movieId: data.movieId,
      url: url,
      fileName: movie.movieFile,
    });
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

module.exports = router;
