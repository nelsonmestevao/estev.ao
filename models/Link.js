const mongoose = require('mongoose');

const { Schema } = mongoose;

const URI = process.env.DB_URI;

mongoose.connect(URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  useCreateIndex: true,
  useFindAndModify: false,
});

const db = mongoose.connection;

db.once('open', () => {
  console.log('Database connected:', db.host);
});

db.on('error', (err) => {
  console.error('connection error:', err);
});

const Link = new Schema({
  slug: { type: String, trim: true, unique: true, index: true, required: true },
  url: { type: String, required: true },
  visits: { type: Number, default: 0 },
  created: { type: Date, default: Date.now },
});

module.exports = mongoose.models.Link || mongoose.model('Link', Link);
