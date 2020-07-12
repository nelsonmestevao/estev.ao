import mongoose, { Schema } from 'mongoose';

const URI = process.env.NEXT_PUBLIC_DB_URI;

mongoose.connect(URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  useCreateIndex: true,
});

const db = mongoose.connection;

db.once('open', () => {
  console.log('Database connected:', db.host);
});

db.on('error', (err) => {
  console.error('connection error:', err);
});

const Link = new Schema({
  slug: { type: String, unique: true, index: true, required: true },
  url: { type: String, required: true },
  visits: { type: Number, default: 0 },
  created: { type: Date, default: Date.now },
});

export default mongoose.models.Link || mongoose.model('Link', Link);
