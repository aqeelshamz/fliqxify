const router = require("express").Router();
const Banner = require("../models/Banner");
const joi = require("joi");
const { default: axios } = require("axios");

router.get("/", async (req, res)=>{
    const banners = await Banner.find();
    let newBanners = [];
    for(const banner of banners){
        const movieId = banner.movieId;
        var response = await axios.get(`https://api.themoviedb.org/3/movie/${movieId}?api_key=3794a566770835ffed011b687794a132&language=en-US`);
        newBanners.push({
            movieId: movieId.toString(),
            imageUrl: banner.imageUrl,
            posterUrl: response.data.poster_path
        });
    }
    res.send(newBanners);
})

router.post("/", async (req, res)=>{
    const schema = joi.object({
        movieId: joi.string().required(),
        imageUrl: joi.string().required()
    });

    try{
        const data = await schema.validateAsync(req.body);
        const newBanner = new Banner({
            movieId: data.movieId,
            imageUrl: data.imageUrl
        });

        await newBanner.save();
        return res.send("Banner created!");
    }
    catch(err){
        return res.status(500).send("Something went wrong");
    }
});

router.post("/delete", async (req, res)=>{
    const schema = joi.object({
        bannerId: joi.string().required(),
    });

    try{
        const data = await schema.validateAsync(req.body);
        await Banner.findByIdAndDelete(data.bannerId);
        return res.send("Banner deleted!");
    }
    catch(err){
        return res.status(500).send("Something went wrong")
    }
})

router.post("/update", async (req, res)=>{
    const schema = joi.object({
        bannerId: joi.string().required(),
        movieId: joi.string().required(),
        imageUrl: joi.string().required()
    });

    try{
        const data = await schema.validateAsync(req.body);
        await Banner.findByIdAndUpdate(data.bannerId, {movieId: data.movieId, imageUrl: data.imageUrl});
    }
    catch(err){
        return res.status(500).send("Something went wrong");
    }
})

module.exports = router;