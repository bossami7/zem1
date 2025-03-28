const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors({
  origin: process.env.NODE_ENV === 'production' 
    ? ['https://your-netlify-app.netlify.app']
    : ['http://localhost:5000', 'http://127.0.0.1:5000']
}));
app.use(express.json());
app.use(express.static('public'));

// Подключение к базе данных
const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgresql://postgres:postgres123@localhost:5432/land_analysis',
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});

// Проверка здоровья сервера
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date() });
});

// Получение всех участков
app.get('/api/lands', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM lands');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching lands:', error);
    res.status(500).json({ error: error.message });
  }
});

// Поиск участков
app.get('/api/lands/search', async (req, res) => {
  const { region } = req.query;
  try {
    const result = await pool.query(
      'SELECT * FROM lands WHERE region ILIKE $1',
      [`%${region}%`]
    );
    res.json(result.rows);
  } catch (error) {
    console.error('Error searching lands:', error);
    res.status(500).json({ error: error.message });
  }
});

// Обработка корневого маршрута
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Обработка 404
app.use((req, res) => {
  res.status(404).json({ error: 'Not Found' });
});

// Обработка ошибок
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Internal Server Error' });
});

// Запуск сервера
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log('Environment:', process.env.NODE_ENV || 'development');
  
  // Тест подключения к БД
  pool.query('SELECT NOW()', (err, res) => {
    if (err) {
      console.error('Database connection error:', err);
    } else {
      console.log('Database connected successfully');
    }
  });
}); 