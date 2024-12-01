const express = require('express');
const mongoose = require('mongoose');
const cartRoutes = require('./routes');
require('dotenv').config();

const app = express();
app.use(express.json());  // Middleware to parse JSON

mongoose.connect(process.env.MONGO_URL)
  .then(() => {
    console.log('Connected to MongoDB');
  })
  .catch((err) => {
    console.log('Error connecting to MongoDB', err);
  });

app.use('/api', cartRoutes);  // Use cart routes

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
