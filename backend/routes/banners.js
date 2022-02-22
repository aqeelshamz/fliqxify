const router = require("express").Router();
const Banner = require("../models/Banner");
const joi = require("joi");

router.get("/", async (req, res)=>{
    res.send(await Banner.find());
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