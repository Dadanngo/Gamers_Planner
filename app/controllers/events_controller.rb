class EventsController < ApplicationController
  def new
    @event = Event.new
    @event.event_times.build
  end

  def create
     puts "イベント作成時のパラメータ: #{params[:event].inspect}"
    @event = Event.new(event_params)
    @event.user = current_user if current_user.present?

    if params[:event][:start_times].present?
      params[:event][:start_times].each do |start_time_str|
        @event.event_times.create(start_time: DateTime.strptime(start_time_str, '%m/%d (%a) %H時'))
      end
    end

    if @event.save
      redirect_to @event, notice: 'イベントが作成されました'
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :game_id, :data_center_id, :hunter_id, :lobby_id, event_times_attributes: [:start_time])
  end
end
