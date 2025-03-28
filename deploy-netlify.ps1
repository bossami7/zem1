# Скрипт автоматического деплоя на Netlify
Write-Host "Начинаем процесс деплоя на Netlify..." -ForegroundColor Cyan

# Проверка Git
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git не установлен. Устанавливаем..." -ForegroundColor Yellow
    winget install --id Git.Git -e --source winget
    Write-Host "Git установлен" -ForegroundColor Green
}

# Проверка Node.js
if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "Node.js не установлен. Устанавливаем..." -ForegroundColor Yellow
    winget install OpenJS.NodeJS
    Write-Host "Node.js установлен" -ForegroundColor Green
}

# Установка зависимостей
Write-Host "Устанавливаем зависимости..." -ForegroundColor Yellow
npm install

# Инициализация Git
Write-Host "Инициализация Git репозитория..." -ForegroundColor Yellow
git init
git add .
git commit -m "Initial commit for Netlify deployment"

# Создание репозитория на GitHub
Write-Host "
Теперь вам нужно:
1. Перейти на GitHub (https://github.com)
2. Создать новый репозиторий
3. Скопировать URL репозитория (например: https://github.com/username/repo.git)
" -ForegroundColor Magenta

$repoUrl = Read-Host "Вставьте URL вашего GitHub репозитория"

# Привязка и пуш в GitHub
git remote add origin $repoUrl
git push -u origin main

# Открытие Netlify
Write-Host "
Теперь настроим Netlify:
1. Откройваю Netlify в браузере...
2. Войдите в аккаунт (или зарегистрируйтесь)
3. Нажмите 'Add new site' -> 'Import an existing project'
4. Выберите ваш GitHub репозиторий
5. В настройках деплоя оставьте всё по умолчанию
6. Нажмите 'Deploy site'
" -ForegroundColor Cyan

Start-Process "https://app.netlify.com"

# Ожидание URL сайта
Write-Host "
После деплоя:
1. Скопируйте URL вашего сайта с Netlify (например: https://your-site-name.netlify.app)
2. Вставьте его ниже для проверки
" -ForegroundColor Yellow

$siteUrl = Read-Host "Вставьте URL вашего Netlify сайта"

# Проверка деплоя
Write-Host "Проверяем деплой..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri $siteUrl -Method Get
    if ($response.StatusCode -eq 200) {
        Write-Host "Сайт успешно развернут и доступен по адресу: $siteUrl" -ForegroundColor Green
    }
} catch {
    Write-Host "Ошибка при проверке сайта: $_" -ForegroundColor Red
}

Write-Host "
Итоги деплоя:
1. GitHub репозиторий: $repoUrl
2. Netlify сайт: $siteUrl

Деплой завершен! Ваш сайт доступен по адресу: $siteUrl
" -ForegroundColor Cyan 