import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import jaLocale from '@fullcalendar/core/locales/ja';

// FullCalendarの初期化。日付がクリックされるとhandleDateClickが呼ばれる。
export function initializeCalendar() {
    let calendarEl = document.getElementById('calendar');
    if (calendarEl) {
        let calendar = new Calendar(calendarEl, {
            plugins: [dayGridPlugin, interactionPlugin],
            initialView: 'dayGridMonth',
            locale: jaLocale,
            selectable: true,
            select: function(info) {
                handleDateRangeSelect(info);
            },
            dateClick: function(info) {
                addDateToCandidates(new Date(info.dateStr));
            }
        });
        calendar.render();
    }
}

function addDateToCandidates(date) {
    let dateCandidates = document.getElementById('date_candidates');
    let form = document.querySelector('form');

    // 表示用フォーマット
    let dateStr = `${date.getMonth() + 1}/${date.getDate()} (${['日','月','火','水','木','金','土'][date.getDay()]})`;
    let defaultTime = "00:00";
    let dateTimeStr = `${dateStr} ${defaultTime}`;

    // 既存コードの中身をほぼそのまま移動 (クリック時と同じ処理)
    let index = document.querySelectorAll('.date-group .dates input[type="hidden"]').length;

    let existingCandidate = dateCandidates.querySelector('.date-group');
    if (!existingCandidate) {
        existingCandidate = document.createElement('div');
        existingCandidate.className = 'p-4 border border-gray-300 rounded-md date-group';
        dateCandidates.appendChild(existingCandidate);
    }
    
    // 実際に日付を並べる子要素コンテナ
    let existingDatesContainer = existingCandidate.querySelector('.dates');
    if (!existingDatesContainer) {
        existingDatesContainer = document.createElement('div');
        existingDatesContainer.className = 'dates mt-2 flex flex-wrap';
        existingCandidate.appendChild(existingDatesContainer);
    }

    let existingDates = Array.from(existingDatesContainer.children).map(el => el.querySelector('input[type="hidden"]').value);
    if (!existingDates.includes(dateTimeStr)) {
        let newDateContainer = document.createElement('div');
        newDateContainer.className = 'flex items-center mb-2 space-x-2';

        let newDate = document.createElement('input');
        newDate.type = 'hidden';
        newDate.name = `event[event_times_attributes][${index}][start_time]`;
        newDate.value = dateTimeStr;

        let timeInput = document.createElement('input');
        timeInput.type = 'time';
        timeInput.value = defaultTime;
        timeInput.className = 'ml-2 p-1 border border-gray-300 rounded-md';

        // 時間が変更されたら隠しフィールドも更新
        timeInput.addEventListener('change', function() {
            newDate.value = `${dateStr} ${timeInput.value}`;
        });

        // 日付け削除ボタン作成
        let removeButton = document.createElement('button');
        removeButton.type = 'button';
        removeButton.textContent = '×';
        removeButton.className = 'ml-2 px-2 py-1 text-white bg-red-500 rounded hover:bg-red-600';
        removeButton.addEventListener('click', function() {
            newDateContainer.remove();
            if (existingDatesContainer.children.length === 0) {
                existingCandidate.remove();
            }
        });

        newDateContainer.appendChild(newDate);
        newDateContainer.appendChild(document.createTextNode(dateStr));
        newDateContainer.appendChild(timeInput);
        newDateContainer.appendChild(removeButton);
        existingDatesContainer.appendChild(newDateContainer);

        // フォームにも追加
        form.appendChild(newDate.cloneNode(true));
    }
}

function handleDateRangeSelect(info) {
    // info.start, info.end は Date オブジェクト
    // FullCalendar の仕様で end は「翌日0時」になるので -1日して調整
    let startDate = new Date(info.start);
    let endDate = new Date(info.end);
    endDate.setDate(endDate.getDate() - 1);

    // 選択範囲の日付を1日ずつループ
    let currentDate = new Date(startDate);
    while (currentDate <= endDate) {
        addDateToCandidates(currentDate);
        currentDate.setDate(currentDate.getDate() + 1);
    }
}
