const express = require('express');
const cors = require('cors');
const mongoose = require('./database'); // Import the Mongoose connection

const app = express();

app.use(cors());
app.use(express.json());

// Root URL route
app.get('/', (req, res) => {
    res.send('★★★★★ Welcome to the  MongoDB API ★★★★★');
});

// Define routes
app.get('/barbershops', async (req, res) => {
    try {
        const Barbershop = mongoose.connection.collection('cheonan_test'); // Access the correct collection
        const results = await Barbershop.find({}).toArray(); // Fetch all documents from the collection
        res.json(results);
    } catch (error) {
        console.error('Error fetching data:', error);
        res.status(500).send('Failed to retrieve data');
    }
});

// Listen on the specified port
const PORT = 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
