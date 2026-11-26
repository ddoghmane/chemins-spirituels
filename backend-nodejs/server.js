const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

mongoose
  .connect("mongodb://127.0.0.1:27017/chemins_spirituels")
  .then(() => console.log("✅ MongoDB connecté"))
  .catch((err) => console.error("❌ Erreur MongoDB :", err));

const Imam = mongoose.model(
  "Imam",
  new mongoose.Schema({}, { strict: false }),
  "imams"
);

const Invocation = mongoose.model(
  "Invocation",
  new mongoose.Schema({}, { strict: false }),
  "invocations"
);

app.get("/", (req, res) => {
  res.json({
    message: "API Chemins Spirituels",
    status: "OK",
  });
});

app.get("/api/imams", async (req, res) => {
  try {
    const data = await Imam.find();
    res.json(data);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
});

app.get("/api/imams/:nom", async (req, res) => {
  try {
    const nom = decodeURIComponent(req.params.nom);

    const imam = await Imam.findOne({
      nom: nom,
    });

    if (!imam) {
      return res.status(404).json({
        error: "Personnage introuvable",
      });
    }

    res.json(imam);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
});

app.get("/api/invocations", async (req, res) => {
  try {
    const data = await Invocation.find();
    res.json(data);
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
});

app.get("/api/invocations/sheikh/:nom", async (req, res) => {
  try {
    const nom = decodeURIComponent(req.params.nom);

    const data = await Invocation.find({
      imam: nom,
    });

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
