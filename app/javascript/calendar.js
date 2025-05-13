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
            dateClick: function(info) {
                handleDateClick(info);
            }
        });
        calendar.render();
    }
}

function handleDateClick(info) {
    let dateCandidates = document.getElementById('date_candidates');
    let form = document.querySelector('form');

    //クリックされた日付を「月/日 (曜日)」形式に整形
    let date = new Date(info.dateStr);
    let dateStr = `${date.getMonth() + 1}/${date.getDate()} (${['日', '月', '火', '水', '木', '金', '土'][date.getDay()]})`;
    let defaultTime = "00:00";
    let dateTimeStr = `${dateStr} ${defaultTime}`;

    // すでに同じ日付が存在するか確認
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
            console.log("Updated hidden input value:", newDate.value);

            let hiddenInputInForm = form.querySelector(`input[name="event[event_times_attributes][${index}][start_time]"]`);
            if (hiddenInputInForm) {
                hiddenInputInForm.value = newDate.value;
            }
        });

        // 日付け削除ボタン作成
        let removeButton = document.createElement('button');
        removeButton.type = 'button';
        removeButton.textContent = '×';
        removeButton.className = 'ml-2 px-2 py-1 text-white bg-red-500 rounded hover:bg-red-600';

        // 削除ボタンのイベントリスナー
        removeButton.addEventListener('click', function() {
            newDateContainer.remove(); // 表示削除
            let hiddenInputInForm = form.querySelector(`input[name="event[event_times_attributes][${index}][start_time]"]`);
            if (hiddenInputInForm) {
                hiddenInputInForm.remove(); // フォームの隠しフィールドも削除
            }

            // すべての候補が削除された場合、.date-group も削除
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
