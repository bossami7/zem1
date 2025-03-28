# Скрипт проверки деплоя
Write-Host "🔍 Проверка статуса деплоя..." -ForegroundColor Cyan

# Запрос URL'ов из пользователя
$railwayUrl = Read-Host "Введите URL вашего Railway приложения"
$netlifyUrl = Read-Host "Введите URL вашего Netlify сайта"

# Проверка бэкенда
Write-Host "⚡ Проверка бэкенда..." -ForegroundColor Yellow
try {
    $backendHealth = Invoke-RestMethod -Uri "https://$railwayUrl/health" -Method Get
    Write-Host "✅ Бэкенд работает! Статус: $($backendHealth.status)" -ForegroundColor Green
} catch {
    Write-Host "❌ Ошибка бэкенда: $_" -ForegroundColor Red
}

# Проверка фронтенда
Write-Host "🌐 Проверка фронтенда..." -ForegroundColor Yellow
try {
    $frontendResponse = Invoke-WebRequest -Uri "https://$netlifyUrl" -Method Get
    if ($frontendResponse.StatusCode -eq 200) {
        Write-Host "✅ Фронтенд доступен!" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Ошибка фронтенда: $_" -ForegroundColor Red
}

# Проверка API
Write-Host "🔄 Проверка API..." -ForegroundColor Yellow
try {
    $apiResponse = Invoke-RestMethod -Uri "https://$netlifyUrl/api/lands" -Method Get
    Write-Host "✅ API работает! Найдено участков: $($apiResponse.Count)" -ForegroundColor Green
} catch {
    Write-Host "❌ Ошибка API: $_" -ForegroundColor Red
}

Write-Host "
📊 Итоги проверки:
1. Бэкенд (Railway): https://$railwayUrl
2. Фронтенд (Netlify): https://$netlifyUrl
3. API endpoint: https://$netlifyUrl/api/lands
" -ForegroundColor Cyan

# Открытие мониторинга
Write-Host "🔍 Открываем панели мониторинга..." -ForegroundColor Yellow
Start-Process "https://railway.app/project/YOUR_PROJECT_ID/metrics"
Start-Process "https://app.netlify.com/sites/$($netlifyUrl.Split('.')[0])/deploys" 