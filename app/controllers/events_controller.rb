class EventsController < ApplicationController
  def new
    @event = Event.new
    @event.event_times.build
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user if current_user.present?

    # 主催者のURLランダム作成
    @event.url = SecureRandom.hex(10) unless @event.url.present?

    if params[:event][:start_times].present?
      params[:event][:start_times].each do |start_time_str|
        @event.event_times.create(start_time: DateTime.strptime(start_time_str, '%m/%d (%a) %H時'))
      end
    end

    if @event.save
      # イベント作成後、共有用のtokenを作成
      @schedule_input = ScheduleInput.create(
      event_id: @event.id,
      token: SecureRandom.hex(16)  # トークンの生成
    )
    redirect_to event_by_url_url(@event.url, token: @schedule_input.token), notice: '作成完了'
    else
      render :new
    end
  end

  def show
    # 表示用URLトークン取得
    @event = Event.find_by(url: params[:url])
    # 拡散用URLのトークンを取得
    @schedule_input = ScheduleInput.find_by(token: params[:token]) if params[:token].present?
  end

  private

  def event_params
    params.require(:event).permit(:name, :game_id, :data_center_id, :hunter_id, :lobby_id, :url, event_times_attributes: [ :start_time ])
  end
end
