// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("turbo:load", function() {
    // Flowbiteの機能を適用
    if (typeof initFlowbite === "function") {
        initFlowbite();
    }
});

document.addEventListener("turbo:load", function() {
    document.documentElement.classList.add('tailwind-loaded');
});
