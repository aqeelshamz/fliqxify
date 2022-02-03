const express = require("express");
const router = express.Router();
const joi = require("joi");
const axios = require("axios");

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
          for(var video of videos){
            if(video.name.toString().toLowerCase().includes("trailer")){
                trailerUrl = "https://youtube.com/watch?v=" + video.key;
                break;
            }
          }
          return res.json({trailer_url: trailerUrl});
      })
      .catch((err) => {
        return res.status(500).send("Something went wrong");
      });
  } catch (err) {
    return res.status(500).send("Something went wrong");
  }
});

module.exports = router;
