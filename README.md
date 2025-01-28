# Gamer's Planner
## ■サービス概要
### Gamer's Plannerはゲームプレイヤー同士の予定表作成に特化した

### 日程調整サービスです。 簡単に日程調整表を作成できるだけでなく、

### **DISCORDで通知が受け取れるユニークなサービスです**。

## ■ このサービスへの思い・作りたい理由
オンラインゲームの主催者として複数人の日程調整を行うことが多々ありました。
当初はエクセルに日程を記入し、参加可能な日程を入力する形式で調整していました。しかし、日程表の確認漏れが頻発した為、都度前日や当日にリマインドを行う事にしました。
主催者として日程調整と同時にリマインドも作成してくれるサービスがあったら便利になると考え、
本サービスを作成することにいたりました。

## ■ ユーザー層について
マルチプレイゲームをプレイしているユーザーで、頻繁にオンラインゲームイベントを主催または参加する人。

## ■サービスの利用イメージ
- **主催者**
 1. 主催者は指定した日程範囲から日程調整表を作成。URLリンクが作成されるので、リンクを参加者へ共有。

 2. 主催者と参加者がすべて記入している事を確認後、日付抽出ツールで全員が参加可能な日付を参加日（以下「活動日」という）として抽出。

 3. <<DISCORD通知が欲しい場合>>>　使用方法詳細ページを読み、Discord「webhook」と本サービスを紐づけする。
  
- **参加者**

   参加者は主催者から共有されたURLリンクからゲームに参加可能な日付を記入。活動日の参照先は同リンクから参照する。
 
- **共通**

  活動日一覧をDiscordの「webhook」、LINEの「LINE Messaging」 経由でリマインド機能として通知。 

  日程変更は主催者が作成したURLリンクから編集する。

## ■ ユーザーの獲得について
ゲームを主催している友人（１０人前後）からサービスを使用してもらうようにします。

また、私のTwitterゲームアカウントでも同じゲームをプレイしている方がたくさんいるのでそちらでも宣伝をし、サービスを広めていきたいと考えています。

## ■ サービスの差別化ポイント・推しポイント
日程調整サービスの中にDiscordに予定を通知するサービスは既にございます。

しかし、スマホの閲覧や編集に適した日程調整サービスが存在しない事が現状でございます。

本サービスでは推しポイントとして、

### スマホの閲覧時でも快適に利用できるオンラインゲームに適した日程調整サービスです。

具体的な特徴

1. 自分のキャラクターのジョブを選択可能。
　
  
    ユーザーはプルダウンから自分のキャラクタージョブを選択可能です。それによりユーザーの判別が容易になります。
    

2. スマホ閲覧時でも予定を一目で確認可能

    スマホ閲覧時でも本日の日付や活動日が視覚的に分かりやすく表示される事により、
    
    自分の予定入力フォームがすぐ見つかり、予定確認や編集がスムーズです。

これらの特徴により、従来のサービスに比べて、より効率的かつストレスフリーに日程調整を行うことができます。

 また、会員登録をする事で主催者は過去に作成した予定表を使い回す事ができ、より迅速な予定表の作成が可能です。

## ■ 機能候補
### MVP
- 会員登録
- ログイン
- 使用方法詳細（Discord「webhook」の使い方）
- 問い合わせ
- （主催者用）カレンダー機能を使用した予定表作成機能＆URL発行
- （参加者用）予定表入力フォーム
- 日程調整表のレスポンシブ対応
- 予定一覧
- DISCORD通知連携機能
- 自分のキャラクターのジョブをプルダウンから選択し、調整欄に反映できる機能

### その後の機能
- LINE通知連携機能
- 予定日をOutlookやGoogleカレンダーに連携させる機能。
- Discord連携機能で当日の直近２週間の予定を入力していない人に入力を促す機能

## ■ 機能の実装方針予定
-  URLトークンの実装　→secure　random（Rubyモジュール）
-  LINE連携　→　LINE Messaging API
-  DISCORD連携 →　webhook
-  通知機能の実装　→　WebSocket、 ActionCable（Rails標準）
- カレンダー機能を使用した予定表作成 →　simple_calendar（Rails標準）
- URL発行　→　Shorten（Rails標準）

### 画面遷移図
Figma：https://www.figma.com/design/qZTFAiLOH5aGPKNGJSBp0W/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=F9ypBhbSxonFZAAu-1

### READMEに記載した機能
- [✔] 会員登録機能
- [✔] ログイン機能
- [✔] パスワード変更機能
- [✔] 使用方法詳細
- [✔] 問い合わせフォーム
- [✔] （主催者用）カレンダー機能を使用した予定表作成機能＆URL発行
- [✔] （参加者用）予定表入力フォーム
- [✔] 予定一覧機能
- [✔] 予定表作成機能
- [✔] LINE通知連携機能
- [✔] DISCORD通知連携機能
- [✔] 予定表に自分のキャラクターUIや情報を表示できる機能。
- [✔] Discord連携機能で当日の直近２週間の予定を入力していない人に入力を促す機能

### 未ログインでも閲覧または利用できるページ
以下の項目は適切に未ログインでも閲覧または利用できる画面遷移になっているか？
- [✔] 予定表作成機能
- [✔] 使用方法詳細

### メールアドレス・パスワード変更確認項目
直接変更できるものではなく、一旦メールなどを介して専用のページで変更する画面遷移になっているか？
- [✔] メールアドレス
- [✔] パスワード

### 各画面の作り込み
画面遷移だけでなく、必要なボタンやフォームが確認できるくらい作り込めているか？
- [✔] 作り込みはある程度完了している（Figmaを見て画面の作成ができる状態にある）

### ER図
drawio: https://app.diagrams.net/?lang=ja#G100g26hi8TETFZ2gDkguFO0ltgTupikJM#%7B%22pageId%22%3A%22C5RBs43oDa-KdzZeNtuy%22%7D