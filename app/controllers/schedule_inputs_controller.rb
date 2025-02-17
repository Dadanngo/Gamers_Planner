class ScheduleInputsController < ApplicationController
    before_action :set_event
    before_action :set_schedule_input, only: [ :index ]

    def new
      @schedule_input = @event.schedule_inputs.new
      # 各 event_time の ID をキーにした初期データをセット
      @schedule_input.response = @event.event_times.each_with_object({}) do |event_time, hash|
       hash[event_time.id.to_s] = nil
       end.to_json
    end

    def create
      @schedule_input = @event.schedule_inputs.new(schedule_input_params.except(:event_time_id))
      # URLトークン作成
      @schedule_input.token = SecureRandom.hex(16)
      # JSONに変換
      @schedule_input.response = schedule_input_params[:response].to_json
      @schedule_input.event_time_id = schedule_input_params[:event_time_id].values.first.to_i if schedule_input_params[:event_time_id].present?
      if @schedule_input.save
        redirect_to event_schedule_inputs_path(@event), notice: '登録完了しました'
      else
        render :new
      end
    end

    def index
      @schedule_inputs = @event.schedule_inputs
    end

  private

  def schedule_input_params
    params.require(:schedule_input).permit(:player_name, :job, response: {}, comment: {}, event_time_id: {})
  end

  def set_event
  @event = Event.find(params[:event_id])
  rescue ActiveRecord::RecordNotFound
  flash[:alert] = "イベントが見つかりません。"
  redirect_to root_path
  end

  def set_schedule_input
    if params[:token].present?
      @schedule_input = ScheduleInput.find_by(token: params[:token])
    else
      flash[:alert] = "スケジュール情報が見つかりません。"
      redirect_to root_path
    end
  end
end
