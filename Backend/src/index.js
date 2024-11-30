const express = require('express');
const bodyParser = require('body-parser');
require('dotenv').config();
const mongoose = require('mongoose');
const app = express();
const cors = require('cors');
app.use(cors());

app.use(bodyParser.json());

const mongoURI = process.env.MONGODB_URI;
mongoose.connect(mongoURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('MongoDB connection error:', err));

app.use(express.json());

app.post('/verify', async (req, res) => {
  const { rollnumber } = req.body;

  if (!rollnumber) {
    return res.status(400).json({ status: 'failure', message: 'Roll number is required' });
  }

  try {
    const user = await mongoose.connection.db.collection('Users').findOne({ rollnumber });

    if (user) {
      console.log(`Roll Number: ${user.rollnumber}, Name: ${user.name}`);
      res.status(200).json({ status: 'success', message: 'Roll number found', user });
    } else {
      res.status(404).json({ status: 'failure', message: 'Roll number not found in users collection.' });
    }
  } catch (err) {
    console.error('Error occurred:', err);
    res.status(500).json({ status: 'error', message: 'An error occurred while checking the roll number in users collection' });
  }
});

app.post('/admin-verify', async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ status: 'failure', message: 'Username and password are required' });
  }

  try {
    const admin = await mongoose.connection.db.collection('admin').findOne({ username, password });

    if (admin) {
      console.log(`Admin Username: ${admin.username}`);
      res.status(200).json({ status: 'success', message: 'Admin authenticated', admin });
    } else {
      res.status(404).json({ status: 'failure', message: 'Invalid username or password' });
    }
  } catch (err) {
    console.error('Error occurred:', err);
    res.status(500).json({ status: 'error', message: 'An error occurred while checking the admin credentials' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});