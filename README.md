# Платформа анализа земельных участков

Веб-приложение для поиска и анализа земельных участков с использованием карт и базового анализа пригодности.

## Локальное тестирование

1. Клонируйте репозиторий:
```bash
git clone [URL репозитория]
cd land-platform
```

2. Установите зависимости:
```bash
npm install
```

3. Настройте базу данных PostgreSQL:
```bash
psql -U postgres -f setup_db.sql
```

4. Запустите сервер:
```bash
npm run dev
```

5. Откройте в браузере:
```
http://localhost:5000
```

## Деплой на Netlify

1. Создайте новый проект на Netlify
2. Подключите ваш GitHub репозиторий
3. Настройте переменные окружения в Netlify:
   - DATABASE_URL: ваш URL базы данных
   - PORT: 5000

## Структура проекта

- `public/` - Статические файлы и фронтенд
- `server.js` - Основной файл сервера
- `setup_db.sql` - Скрипт инициализации базы данных
- `netlify.toml` - Конфигурация для Netlify

## API Endpoints

- GET `/api/lands` - Получить все участки
- GET `/api/lands/search?region=XXX` - Поиск по региону

## Технологии

- Frontend: HTML5, CSS3, JavaScript, Bootstrap 5
- Backend: Node.js, Express
- Database: PostgreSQL
- Maps: Leaflet.js
- Deployment: Netlify 