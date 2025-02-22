class ScheduleInputsController < ApplicationController
    before_action :set_event
    before_action :set_schedule_input, only: [ :edit, :update, :destroy ]

    def new
      @schedule_input = @event.schedule_inputs.find_by(token: params[:token])
      if @schedule_input.nil?
        @schedule_input = @event.schedule_inputs.new
        @schedule_input.token = SecureRandom.hex(16)
        @schedule_input.response = @event.event_times.each_with_object({}) { |event_time, hash| hash[event_time.id.to_s] = nil }.to_json
      else
        @schedule_input = @event.schedule_inputs.new
      end
    end

    def create
      @schedule_input = @event.schedule_inputs.new(schedule_input_params.except(:event_time_id))
      # URLトークン作成
      @schedule_input.token = SecureRandom.hex(16)
      # JSONに変換
      @schedule_input.response = schedule_input_params[:response].to_json
      @schedule_input.comment = schedule_input_params[:comment].values.any?(&:present?) ? schedule_input_params[:comment].to_json : nil
      
      @schedule_input.event_time_id = schedule_input_params[:event_time_id].values.first.to_i if schedule_input_params[:event_time_id].present?

      if @schedule_input.save
        redirect_to event_schedule_inputs_by_url_path(@event.url), notice: '登録完了しました'
      else
        flash[:alert] = "登録に失敗しました。入力内容に不足があります。"
        render :new
      end
    end

    def index
      @event = Event.find_by(url: params[:url])

      unless @event
        flash[:alert] = "イベントが見つかりません。"
        redirect_to root_path and return
      end

      @schedule_inputs = @event.schedule_inputs
    end


    def edit
      @event = Event.find_by(url: params[:url]) # URLでイベントを取得
      @schedule_input = @event.schedule_inputs.find_by(token: params[:token])
    end

    def update
      updated_params = schedule_input_params
      updated_params[:response] = updated_params[:response].to_json
      updated_params[:comment] = updated_params[:comment].to_json if updated_params[:comment].present?

      if @schedule_input.update(updated_params)
        redirect_to event_schedule_inputs_by_url_path(@event.url), notice: '日程を更新しました'
      end
    end

    def destroy
      @schedule_input = @event.schedule_inputs.find_by(token: params[:token])

      if @schedule_input.nil?
        flash[:alert] = "スケジュールが見つかりません。"
        redirect_to event_schedule_inputs_path(@event) and return
      end

      if @schedule_input.destroy
        flash[:notice] = "ユーザーを削除しました。"
      end
      redirect_to event_schedule_inputs_by_url_path(@event.url)
    end

  private

  def schedule_input_params
    params.require(:schedule_input).permit(:player_name, :job, response: {}, comment: {}, event_time_id: {})
  end

  def set_event
    if params[:event_id].present?
      @event = Event.find_by(id: params[:event_id])
    elsif params[:url].present?
      @event = Event.find_by(url: params[:url])
    end

    unless @event
      flash[:alert] = "イベントが見つかりません。"
      redirect_to root_path
    end
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
