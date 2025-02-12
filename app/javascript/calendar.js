import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import jaLocale from '@fullcalendar/core/locales/ja';

export function initializeCalendar() {
    var calendarEl = document.getElementById('calendar');
    if (calendarEl) {
        var calendar = new Calendar(calendarEl, {
            plugins: [dayGridPlugin, interactionPlugin],
            initialView: 'dayGridMonth',
            locale: jaLocale,
            selectable: true,
            dateClick: function(info) {
                handleDateClick(info);
            }
        });
        calendar.render();
    }
}

function handleDateClick(info) {
    var dateCandidates = document.getElementById('date_candidates');
    var form = document.querySelector('form');  

    var date = new Date(info.dateStr);
    var dateStr = `${date.getMonth() + 1}/${date.getDate()} (${['日', '月', '火', '水', '木', '金', '土'][date.getDay()]})`;

    // 初期時間を 00:00 に設定（ユーザーが変更可能にする）
    var defaultTime = "00:00";

    var dateTimeStr = `${dateStr} ${defaultTime}`;

    var index = document.querySelectorAll('.date-group .dates input[type="hidden"]').length;

    var existingCandidate = dateCandidates.querySelector('.date-group');
    if (!existingCandidate) {
        existingCandidate = document.createElement('div');
        existingCandidate.className = 'p-4 border border-gray-300 rounded-md date-group';
        dateCandidates.appendChild(existingCandidate);
    }

    var existingDatesContainer = existingCandidate.querySelector('.dates');
    if (!existingDatesContainer) {
        existingDatesContainer = document.createElement('div');
        existingDatesContainer.className = 'dates mt-2 flex flex-wrap';
        existingCandidate.appendChild(existingDatesContainer);
    }

    var existingDates = Array.from(existingDatesContainer.children).map(el => el.querySelector('input[type="hidden"]').value);
    if (!existingDates.includes(dateTimeStr)) {
        var newDateContainer = document.createElement('div');
        newDateContainer.className = 'flex items-center mb-2';

        var newDate = document.createElement('input');
        newDate.type = 'hidden';
        newDate.name = `event[event_times_attributes][${index}][start_time]`;
        newDate.value = dateTimeStr;

        var timeInput = document.createElement('input');
        timeInput.type = 'time';
        timeInput.value = defaultTime;
        timeInput.className = 'ml-2 p-1 border border-gray-300 rounded-md';

        // 時間が変更されたら隠しフィールドも更新
        timeInput.addEventListener('change', function() {
            newDate.value = `${dateStr} ${timeInput.value}`;
            console.log("Updated hidden input value:", newDate.value); // デバッグ用

            // フォームの隠しフィールドも更新
            var hiddenInputInForm = form.querySelector(`input[name="event[event_times_attributes][${index}][start_time]"]`);
            if (hiddenInputInForm) {
                hiddenInputInForm.value = newDate.value;
            }
        });

        newDateContainer.appendChild(newDate);
        newDateContainer.appendChild(document.createTextNode(dateStr));
        newDateContainer.appendChild(timeInput);
        existingDatesContainer.appendChild(newDateContainer);

        // フォームにも追加
        form.appendChild(newDate.cloneNode(true));
    }
}

