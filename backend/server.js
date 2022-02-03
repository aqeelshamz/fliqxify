const express = require("express");
const app = express();
const port = process.env.PORT || 3030;
require("dotenv").config();

const mongoose = require("mongoose");

mongoose.connect(process.env.DB_URL, (err) => {
  if (!err) console.log("DB Connected!");
});

const usersRouter = require("./routes/user");
const plansRouter = require("./routes/plans");

app.use(express.json());

app.get("/", (req, res) => {
  res.send("Fliqxify backend");
});

app.use("/users", usersRouter);
app.use("/plans", plansRouter);

app.listen(port, () => {
  console.log("Server started on port " + port);
});
