# Gamer's Planner
## ■サービス概要
### Gamer's Plannerはゲームプレイヤー同士の予定表作成に特化した

### 日程調整サービスです。 簡単に日程調整表を作成できるだけでなく、

### **LINEやDISCORDで通知が受け取れるユニークなサービスです**。

## ■ このサービスへの思い・作りたい理由
オンラインゲームの主催者として複数人の日程調整を行うことが多々ありました。
当初はエクセルに日程を記入し、参加可能な日程を入力する形式で調整していました。
しかし、日程表の確認漏れが頻発した為、都度前日や当日にリマインドを行う事にしました。
主催者として日程調整と同時にリマインドも作成してくれるサービスがあったら便利になると考え、
本サービスを作成することにいたりました。

## ■ ユーザー層について
マルチプレイゲームをプレイしているユーザーで、頻繁にオンラインゲームイベントを主催または参加する人。

## ■サービスの利用イメージ
- **主催者**
 1. 主催者は指定した日程範囲から日程調整表を作成。URLリンクが作成されるので、リンクを共有。

 2. 主催者と参加者がすべて記入している事を確認後、日付抽出ツールで全員が参加可能な日付を参加日（以下「活動日」という）

　　として抽出。

 3. <<DISCORD通知が欲しい場合>>>　使用方法詳細ページを読み、Discord「webhook」と本サービスを紐づけ。
  
- **参加者**

　 参加者は主催者から共有されたURLリンクからゲームに参加可能な日付を記入。活動日の参照先は同URLから参照する。
 
- **共通**

　活動日一覧をDiscordの「webhook」、LINEの「LINE Messaging」 経由でリマインド機能として通知。 

　日程変更は主催者が作成したURLリンクから編集する。

## ■ ユーザーの獲得について
ユーザーからのフィードバックを問い合わせフォームで収集し、サービスに反映することで、

サービスの満足度を向上させます。結果として新規ユーザーの獲得へとつながると考えます。

## ■ サービスの差別化ポイント・推しポイント
日程調整サービスの中にDiscordに予定を通知するサービスは既にございます。

 - 本サービスではそれらに加え、LINE通知機能も提供し、Discordを利用しないユーザーにも対応可能です。

   これにより、より幅広いユーザー層にサービスを届けることができます。

 - 会員登録をする事で主催者は過去に作成した予定表を使い回す事ができ、より迅速な予定表の作成が可能です。

## ■ 機能候補
### MVP
- 会員登録
- ログイン
- 使用方法詳細（Discord「webhook」の使い方）
- 問い合わせ
- （主催者用）カレンダー機能を使用した予定表作成機能＆URL発行

- （参加者用）予定表入力フォーム
- 予定一覧
- DISCORD通知連携機能

### その後の機能
- LINE通知連携機能

## ■ 機能の実装方針予定
-  URLトークンの実装　→secure　random（Rubyモジュール）
-  LINE連携　→　LINE Messaging API
-  DISCORD連携 →　webhook
-  通知機能の実装　→　WebSocket、 ActionCable（Rails標準）


