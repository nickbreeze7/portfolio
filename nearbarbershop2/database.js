const mongoose = require('mongoose');

// Connection URL
const url = 'mongodb+srv://nickcaestro:XAcwo43TNfSXJc0x@cluster0.9tsdj.mongodb.net/barbershop_test?retryWrites=true&w=majority';

// Connect to MongoDB
mongoose.connect(url, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => {
  console.log("Connected successfully to MongoDB server");
}).catch(err => {
  console.error('Error connecting to MongoDB: ', err);
  process.exit(1);
});

// Export Mongoose for use in other files
module.exports = mongoose;
