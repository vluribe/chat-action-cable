class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room_id]}_user_#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
