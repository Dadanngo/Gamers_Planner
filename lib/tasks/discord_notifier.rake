namespace :discord do
  desc "17時に現在の schedule_input を保存し、Discord に通知する"
  task save_schedule_and_notify: :environment do
    today = Time.zone.today

    # 通知を希望しているイベントを取得
    events_to_notify = Event.joins(:notification).where(notifications: { notify_daily: true })
    if events_to_notify.empty?
      puts "通知対象のイベントがありません"
      next
    end

    bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'])

    bot.ready do
      puts "Discordに接続しました"

      events_to_notify.each do |event|
        # 本日分の event_times のみ取得
        todays_event_times = event.event_times.select { |et| et.start_time.to_date == today }
        if todays_event_times.empty?
          puts "本日のイベント時刻はありません: Event ID #{event.id}"
          next
        end

        # ステータス生成
        statuses = todays_event_times.map do |event_time|
          responses = event.schedule_inputs.map do |input|
            response_hash = JSON.parse(input.response) rescue {}
            response_hash[event_time.id.to_s]
          end.compact

          time_str = event_time.start_time.in_time_zone.strftime('%H:%M')

          if responses.any? && responses.all? { |r| r == "ok" }
            "✅ あり (#{time_str})"
          elsif responses.include?("ok") || responses.include?("maybe")
            "⚠️ あるかも (#{time_str})"
          else
            nil
          end
        end.compact

        # メッセージ生成
        message =
          if statuses.any?
            "**本日の活動予定**\n" + statuses.join("\n")
          else
            "❌ **本日の活動はありません。**"
          end

        # ユーザーのDiscordサーバーへ送信
        user = event.user
        if user&.discord_server_id.present? && user&.discord_channel_id.present?
          server_id = user.discord_server_id.to_i
          channel_id = user.discord_channel_id.to_i
          discord_server = bot.servers[server_id]

          if discord_server
            channel = discord_server.text_channels.find { |ch| ch.id == channel_id }
            if channel
              channel.send_message(message)
              puts "Discord にメッセージ送信成功: #{message}"
            else
              puts "チャンネルが見つかりません: Server ID #{server_id}"
            end
          else
            puts "Discord サーバーが見つかりません: Server ID #{server_id}"
          end
        else
          puts "ユーザーに Discord サーバーID が未設定です: User ID #{user&.id}"
        end
      end

      bot.stop
    end

    bot.run
  end
end
