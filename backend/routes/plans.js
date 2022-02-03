const express = require("express");
const router = express.Router();

const plans = [
  {
    id: 1,
    name: "Silver",
    features: [
      "1080p Quality Streaming",
      "No Ads",
      "For mobile only"
    ],
    price: 199,
    month: 1
  },
  {
    id: 2,
    name: "Gold",
    features: [
      "1080p Quality Streaming",
      "No Ads",
      "For mobile only"
    ],
    price: 699,
    month: 6
  },
  {
    id: 3,
    name: "Premium",
    features: [
      "4K & 1080p Quality Streaming",
      "No Ads",
      "For mobile & PC"
    ],
    price: 1999,
    month: 12
  }
];

router.get("/", async (req, res) => {
  console.log(req.body);
  res.send(plans);
});

module.exports = router;