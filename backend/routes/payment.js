const router = require("express").Router();
const { validate } = require("../middlewares/validate");
const joi = require("joi");
const stripe = require("stripe")(process.env.STRIPE_KEY);

router.post("/get-client-secret", validate, async (req, res) => {
  const schema = joi.object({
    amount: joi.number().required(),
    currency: joi.string().required(),
  });

  try {
    const data = await schema.validateAsync(req.body);
    const paymentIntent = await stripe.paymentIntents.create({
      amount: data.amount,
      currency: data.currency,
    });

    res.json({ clientSecret: paymentIntent.client_secret });
  } catch (err) {}
});

module.exports = router;
