//非同期でlobby_idを更新する。

document.addEventListener("DOMContentLoaded", function() {
    console.log("ロビーID編集スクリプト読み込み完了");

    const display = document.getElementById("lobby-id-display");
    const input = document.getElementById("lobby-id-input");
    const saveButton = document.getElementById("lobby-id-save"); 
    
    if (!display || !input || !saveButton) return;

    display.addEventListener("click", function() {
        display.classList.add("hidden");
        input.classList.remove("hidden");
        saveButton.classList.remove("hidden");
    });

//値を保存する処理。Railsと連携するための非同期通信 (fetch API + PATCH リクエスト)
    saveButton.addEventListener("click", function() {
        const newValue = input.value;

        fetch(display.dataset.updateUrl, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json",
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({ event: { lobby_id: newValue } })
        })
        .then(response => response.json())
        .then(data => {
            display.textContent = data.lobby_id || "未設定";
            display.classList.remove("hidden");
            input.classList.add("hidden");
            saveButton.classList.add("hidden");
        })
        .catch(error => console.error("Error:", error));
    });
});
