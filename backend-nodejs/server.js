const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

mongoose
  .connect("mongodb://127.0.0.1:27017/invocations")
  .then(() => console.log("✅ MongoDB connecté"))
  .catch((err) => console.error(err));

const InvocationSchema = new mongoose.Schema({
  arabe: String,
  phonetic: String,
  francais: String,
});

const Invocation = mongoose.model(
  "Invocation",
  InvocationSchema,
  "invocations"
);

app.get("/invocations", async (req, res) => {
  try {
    const data = await Invocation.find();
    res.json(data);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
});

app.listen(3000, () => {
  console.log("🚀 API en ligne sur http://localhost:3000");
});
