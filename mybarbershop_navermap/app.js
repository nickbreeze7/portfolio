const express = require('express');
const cors = require('cors');
const db = require('./database'); // Ensure this correctly points to your database.js

const app = express();

app.use(cors());
app.use(express.json());


// Root URL route
app.get('/', (req, res) => {
    res.send('Welcome to the API');
});



app.get('/barbershops', (req, res) => {
   // const id = req.params.id;
   // console.log('Requested ID:============', id);  // Log the ID to see what is received

    const sqlQuery = 'SELECT * FROM changwon5';
    db.query(sqlQuery,  (error, results, fields) => {
        if (error) {
            console.error('Error fetching data:', error);
            return res.status(500).send('Failed to retrieve data');
        }

     /*   if (results.length > 0) {
            res.json(results[0]);
        } else {
            res.status(404).send('No entry found with that ID');
        }*/

        res.json(results);
    });
});


//const PORT = process.env.PORT || 3000;
const PORT =   3000;

// Change localhost to 0.0.0.0 to listen on all network interfaces
/*app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on http://0.0.0.0:${PORT}`);
});*/


app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
