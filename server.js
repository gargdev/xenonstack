const express = require('express');
const colors = require('colors'); // Import the 'colors' library
const morgan = require('morgan');
const dotenv = require('dotenv');
const connectDB = require('./config/db');

// dotenv config (call it at the beginning)
dotenv.config();

// mongodb connection
connectDB();

// rest object
const app = express();

// middlewares
app.use(express.json());
app.use(morgan('dev'));

// routes
app.use('/api/v1/user', require('./routes/userRoutes'));

// port
const port = process.env.PORT || 8080;

// listen port
app.listen(port, () => {
    console.log(`Server running in ${process.env.NODE_ENV} Mode on port ${port}`.bgCyan.white);
});
