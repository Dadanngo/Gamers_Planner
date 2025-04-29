# Gamer's Planner
[![Image from Gyazo](https://i.gyazo.com/916b57a5c770527cad1c0cce05801957.png)](https://gyazo.com/916b57a5c770527cad1c0cce05801957)

## 📝サービス概要
### Gamer's Plannerはゲームプレイヤー同士の予定表作成に特化した

### 日程調整サービスです。 

### 簡単に日程調整表を作成できるだけでなく、

### **DISCORDで通知が受け取れるユニークなサービスです**。

## 🌐 URL
# https://gamersplanner.com

## 💡 サービス開発背景
オンラインゲームの主催者として複数人の日程調整を行うことが多々ありました。
当初はエクセルに日程を記入し、参加可能な日程を入力する形式で調整していました。
しかし、日程表の確認漏れが頻発した為、都度前日や当日にリマインドを行う事にしました。
主催者として日程調整と同時にリマインドも作成してくれるサービスがあったら便利になると考え、
本サービスを作成することにいたりました。

## 📑 目次
機能詳細
- [🔐 ユーザー登録機能](#-ユーザー登録機能)
- [🔑 ログイン機能](#-ログイン機能)
- [📁 MySettings内の機能](#-MySettings内の機能)
- [🗓️ 予定を立てる機能](#-予定を立てる機能)
- [🤝 日程調整機能](#-日程調整機能)
- [🤖 Discord連携機能](#-discord連携機能)

技術構成について
- [⚙️ 使用した技術](#使用した技術)
- [✏️ ER図](#ER図)
- [✏️ 画面遷移図](#画面遷移図)


### 🔐 ユーザー登録機能
[![Image from Gyazo](https://i.gyazo.com/7cc5cdb94d2636b580f26625d8ce2143.jpg)](https://gyazo.com/7cc5cdb94d2636b580f26625d8ce2143)
・必須項目をすべて入力し「保存」ボタンを押すと、認証メールが送信されます。

・メールアドレスは一意であり、同じアドレスで登録することはできません。


[![Image from Gyazo](https://i.gyazo.com/67770905d29700a405b07a76eb6e6bb9.png)](https://gyazo.com/67770905d29700a405b07a76eb6e6bb9)
・会員登録するリンクを押す事で、トップページへリダイレクトし認証が完了します。



### 🔑 ログイン機能
　[![Image from Gyazo](https://i.gyazo.com/257d77f3eac63a8d40d8db617afd3761.gif)](https://gyazo.com/257d77f3eac63a8d40d8db617afd3761)

・メールアドレス + パスワード または Googleログインが可能。

・ログイン後、ナビバーに「MySettings」メニューが表示されます。

### 📁 MySettings内の機能

①マイページ

過去に作成した日程調整を参照・再作成できます。

[![Image from Gyazo](https://i.gyazo.com/b2788631b4c501e6450560e175a6463f.jpg)](https://gyazo.com/b2788631b4c501e6450560e175a6463f)

②Discord連携→後述します。

③ログアウト→ログイン中のユーザーをログアウトします。

### 🗓️ 予定を立てる機能
[![Image from Gyazo](https://i.gyazo.com/69f3f4a92c91bb7be6f6c1b334c1967b.jpg)](https://gyazo.com/69f3f4a92c91bb7be6f6c1b334c1967b)

・イベント名、ゲーム選択、カレンダーで日付選択により、日程調整フォームを作成できます。

・イベント名と日程候補は必須入力です。（1つ以上必要）

[![Image from Gyazo](https://i.gyazo.com/48d92c69a5d01be3d39ad45299b06423.gif)](https://gyazo.com/48d92c69a5d01be3d39ad45299b06423)

・活動時間の変更・削除が可能。（✕ボタンで削除）

・作成後、共有用URLが発行されます。


### 🤝 日程調整機能

「予定を立てる」で作成したURL、またはリンクボタンから日程調整画面へ遷移できます。

参加者は「プレイヤー予定追加」ボタンから予定登録が可能。

| 日程状態 | 色 | 
|:----|:---|
| 〇全員参加可能 | 🟩 緑色 |
| △予定不明 | 🟥 赤色 |
| ✕活動不可 | 無色 |


ロビーIDは非同期で編集可能です。

[![Image from Gyazo](https://i.gyazo.com/0af7daccd98355616fe30942fa521944.png)](https://gyazo.com/0af7daccd98355616fe30942fa521944)

⬇登録までの流れ⬇

[![Image from Gyazo](https://i.gyazo.com/0780a91330ebcb0d9d362072214cc7dd.gif)](https://gyazo.com/0780a91330ebcb0d9d362072214cc7dd)

🔹 備考欄あり（△選択時）プレイヤー名を括弧書きで記入してください！

### 🤖 Discord連携機能
・当日の17時にDiscord通知が可能！（ログインユーザー限定）

👉 詳細マニュアルはこちら

https://gamersplanner.com/manual/show?button3=true


🔄 連携・通知までの流れ


1. 「MySettings」or「つかいかた」からBot導入ページへ移動し、サーバーへBotを招待

2. 通知したいチャンネルでコマンドを実行
```
!set_channel
```

3. 日程調整画面に「Discord通知ボタン」が表示されます。

4. 全員の予定入力を確認後、「通知する」ボタンを押してください。


[![Image from Gyazo](https://i.gyazo.com/bd4684f227d321bc477fca6bbcbdbcd0.png)](https://gyazo.com/bd4684f227d321bc477fca6bbcbdbcd0)

## ⚙️ 使用した技術

| カテゴリー | 技術内容 |
|:-----------|------------:|
| サーバーサイド       | Ruby on Rails 7.2.1・Ruby 3.2.3        |
| フロントエンド     | Ruby on Rails・JavaScript      |
| CSSフレームワーク       | Tailwindcss        |
| Web API         | 	OpenAI API(GPT-4o)・Google API・DiscordAPI          |
| DBサーバー       | PostgreSQL       |
| AP・cron・Botサーバー    | Render     |
| バージョン管理    | Github     |


## ✏️ ER図
[![Image from Gyazo](https://i.gyazo.com/8438f5a34fe30d5b4ef0e10c924743b9.png)](https://gyazo.com/8438f5a34fe30d5b4ef0e10c924743b9)

## ✏️ 画面遷移図
https://www.figma.com/design/qZTFAiLOH5aGPKNGJSBp0W/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&p=f&t=f09naTtaamxiLoLY-0