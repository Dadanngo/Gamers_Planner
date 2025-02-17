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
      # スケジュール入力を作成
      @schedule_input = ScheduleInput.create(
        event_id: @event.id,
        token: SecureRandom.hex(16)  # トークンの生成
      )
      # ここで保存成功/失敗のログを出す
      if @schedule_input.persisted?
        Rails.logger.debug "ScheduleInput created successfully: #{@schedule_input.inspect}"
        redirect_to event_by_url_url(@event.url, token: @schedule_input.token), notice: '作成完了'
      else
        Rails.logger.error "ScheduleInput creation failed: #{@schedule_input.errors.full_messages}"
        flash[:alert] = "スケジュール入力の作成に失敗しました。"
        redirect_to root_path
      end
    else
      render :new
    end
  end

  def show
    @event = Event.find_by(url: params[:url])
    if params[:token].present?
      @schedule_input = ScheduleInput.find_by(token: params[:token])
    else
      @schedule_input = ScheduleInput.where(event_id: @event.id).first
    end

    if @schedule_input.nil?
      flash[:alert] = "スケジュール入力が見つかりませんでした。"
      redirect_to root_path and return
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :game_id, :data_center_id, :hunter_id, :lobby_id, :url, event_times_attributes: [ :start_time ])
  end
end
