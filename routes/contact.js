// routes/contact.js
const express = require("express");
const router = express.Router();
const Contact = require("../models/Contact");

// Contact Us
router.post("/submit", async (req, res) => {
  try {
    const { name, email, message } = req.body;

    // Create a new contact
    const newContact = new Contact({
      name,
      email,
      message,
    });

    await newContact.save();

    res.status(201).json({ message: "Contact submitted successfully" });
  } catch (error) {
    console.error("Error submitting contact form:", error);
    res.status(500).json({ message: "Internal server error" });
  }
});

module.exports = router;
