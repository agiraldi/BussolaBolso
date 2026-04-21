import express from 'express';
import cors from 'cors';

import { authRoutes } from './routes/auth.routes';

const app = express();
const port = process.env.PORT || 3333;

app.use(cors());
app.use(express.json());

// Routes
app.use('/auth', authRoutes);

// Main entry point test route
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', message: 'BussolaBolso API is running!' });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`🚀 Server running on port ${port}`);
});
