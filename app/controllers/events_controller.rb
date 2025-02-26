class EventsController < ApplicationController
  before_action :set_event, only: [ :recreate, :update_lobby_id ]
  def new
    @event = Event.new
    @event.event_times.build

    if session[:cloned_event].present? # recreateからのデータがある場合復元
      @event.assign_attributes(session[:cloned_event])
      session.delete(:cloned_event) # 使い終わったら削除
      session.delete(:cloned_event_times)
    end
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user if current_user.present?
    @event.url = SecureRandom.hex(10) unless @event.url.present?

    if params[:event][:start_times].present?
      params[:event][:start_times].each do |start_time_str|
        @event.event_times.build(start_time: DateTime.strptime(start_time_str, '%m/%d (%a) %H時'))
      end
    end

    if @event.save
      redirect_to event_by_url_path(@event.url), notice: 'イベントが作成されました。'
    else
      flash.now[:alert] = @event.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @event = Event.find_by(url: params[:url])
    if @event.nil?
      flash[:alert] = "イベントが見つかりません。"
      redirect_to root_path and return
    end

    @schedule_input = @event.schedule_inputs.order(:id).first
    # `@schedule_input` がなくてもエラーにしない
  end


  def recreate
    @new_event = @event.dup # 既存のイベントをコピー
    @new_event.url = SecureRandom.hex(10) # 新しいURLを生成
    @new_event.id = nil # 新規オブジェクトとして扱う
    @new_event.event_times = @event.event_times.map { |et| et.dup } # イベント日程も複製

    session[:cloned_event] = @new_event.attributes # 一時保存（セッションに入れる）
    session[:cloned_event_times] = @event.event_times.map(&:attributes)

    redirect_to new_event_path, notice: "再作成します。"
  end

  def update_lobby_id
    if @event.update(lobby_id: params[:event][:lobby_id])
      render json: { lobby_id: @event.lobby_id }
    else
      render json: { error: "更新に失敗しました", messages: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :game_id, :data_center_id, :hunter_id, :lobby_id, :url, event_times_attributes: [ :start_time ])
  end

  def set_event
    if params[:id].present?
      @event = Event.find_by(id: params[:id])
    elsif params[:url].present?
      @event = Event.find_by(url: params[:url])
    end
  end
end
