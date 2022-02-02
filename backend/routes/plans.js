const express = require("express");
const router = express.Router();
const Plan = require("../models/Plan");
const joi = require("joi");

router.get("/", (req, res)=>{
    res.send(await Plan.find());
})

router.post("/", (req, res)=>{
    const schema = joi.object({
        name: joi.string().required(),
        price: joi.number().required(),
        features: joi.array().required(),
        month: joi.number().required()
    })

    try{
        const data = await schema.validateAsync(req.body);
        const newPlan = new Plan({
            name: data.name,
            price: data.price,
            features: data.features,
            month: data.month
        });

        await newPlan.save();
    }
    catch(err){
        return res.status(500).send("Something went wrong")
    }
})

module.exports = router;