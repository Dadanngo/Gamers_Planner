// Entry point for the build script in your package.json
//import "@hotwired/turbo-rails"
import "./controllers"
import { initializeCalendar } from './calendar';

document.addEventListener("DOMContentLoaded", function() {
    console.log("Initializing calendar...");
    // Flowbiteの機能を適用
    if (typeof initFlowbite === "function") {
        initFlowbite();
    }
    // カレンダーの初期化
    initializeCalendar();

    // Tailwind CSSのクラスを追加
    document.documentElement.classList.add('tailwind-loaded');
});
