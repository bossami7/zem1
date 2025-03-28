// Инициализация карты
const map = L.map('map').setView([55.751244, 37.618423], 6);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);

// Функция для анализа участка
function analyzeLand(land) {
    const analysis = {
        suitable: true,
        reasons: []
    };

    if (land.area < 5) {
        analysis.suitable = false;
        analysis.reasons.push('Площадь менее 5 соток');
    }

    if (land.type !== 'ИЖС') {
        analysis.suitable = false;
        analysis.reasons.push('Тип участка не ИЖС');
    }

    return analysis;
}

// Функция для отображения участка на карте
function displayLandOnMap(land) {
    try {
        const coordinates = JSON.parse(land.coordinates);
        const analysis = analyzeLand(land);
        const marker = L.marker(coordinates).addTo(map);
        
        marker.bindPopup(`
            <strong>${land.type}</strong><br>
            Площадь: ${land.area} соток<br>
            Статус: ${analysis.suitable ? '✅ Подходит' : '❌ Не подходит'}<br>
            ${analysis.reasons.join('<br>')}
        `);
    } catch (error) {
        console.error('Ошибка при отображении участка:', error);
    }
}

// Функция поиска участков
async function searchLands() {
    const region = document.getElementById('region').value;
    const resultDiv = document.getElementById('result');
    
    try {
        const response = await fetch(`/api/lands/search?region=${encodeURIComponent(region)}`);
        const lands = await response.json();
        
        // Очищаем карту и результаты
        map.eachLayer((layer) => {
            if (layer instanceof L.Marker) {
                map.removeLayer(layer);
            }
        });
        
        resultDiv.innerHTML = '';
        
        // Отображаем результаты
        lands.forEach(land => {
            const analysis = analyzeLand(land);
            const landElement = document.createElement('div');
            landElement.className = 'land-item';
            landElement.innerHTML = `
                <strong>${land.type}</strong><br>
                Регион: ${land.region}<br>
                Площадь: ${land.area} соток<br>
                Статус: ${analysis.suitable ? '✅ Подходит' : '❌ Не подходит'}<br>
                ${analysis.reasons.join('<br>')}
            `;
            resultDiv.appendChild(landElement);
            displayLandOnMap(land);
        });
    } catch (error) {
        console.error('Ошибка при поиске:', error);
        resultDiv.innerHTML = '<p style="color: red;">Произошла ошибка при поиске участков</p>';
    }
}

// Загрузка всех участков при старте
window.addEventListener('load', async () => {
    try {
        const response = await fetch('/api/lands');
        const lands = await response.json();
        lands.forEach(land => displayLandOnMap(land));
    } catch (error) {
        console.error('Ошибка при загрузке участков:', error);
    }
}); 