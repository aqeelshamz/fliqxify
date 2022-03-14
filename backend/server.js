const express = require("express");
const app = express();
const port = process.env.PORT || 3030;
require("dotenv").config();
const cors = require("cors");
const mongoose = require("mongoose");

mongoose.connect(process.env.DB_URL, (err) => {
  if (!err) console.log("DB Connected!");
});

const usersRouter = require("./routes/users");
const plansRouter = require("./routes/plans");
const moviesRouter = require("./routes/movies");
const bannersRouter = require("./routes/banners");
const historyRouter = require("./routes/history");
const paymentRouter = require("./routes/payment");

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("Fliqxify backend");
});

app.use("/users", usersRouter);
app.use("/plans", plansRouter);
app.use("/movies", moviesRouter);
app.use("/banners", bannersRouter);
app.use("/history", historyRouter);
app.use("/payment", paymentRouter);

app.listen(port, () => {
  console.log("Server started on port " + port);
});
